class Invoice
  include ActiveModel::Model

  attr_accessor :invoice_number, :amount_in_cents
end
