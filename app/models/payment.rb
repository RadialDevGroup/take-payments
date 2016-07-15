class Payment
  include ActiveModel::Model

  attr_accessor :card_token, :amount_in_cents, :description, :invoice_number
  mattr_accessor :stripe_logo_path

  alias_method :amount, :amount_in_cents
  alias_method :amount=, :amount_in_cents=

  def stripe_attributes
    {
      key: ENV['STRIPE_PUBLIC_KEY'],
      name: ENV['COMPANY_NAME'],
      description: description,
      amount: amount,
      image: stripe_logo_path
    }
  end

  def amount_in_dollars
    amount_in_cents.to_i / 100.0 rescue 0
  end

  def description
    @description ||= "Invoice ##{invoice_number}"
  end

  def save
    begin
      Stripe::Charge.create({
        description: description,
        amount: amount_in_cents,
        source: card_token,
        currency: 'USD'
      })
    rescue Stripe::CardError => e
      errors.add(:processor, e.message)

      return false
    end
  end
end
