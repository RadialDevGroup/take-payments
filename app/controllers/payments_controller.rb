class PaymentsController < ApplicationController
  def new
    @payment = Payment.new initial_payment_params.slice(:amount_in_cents, :amount, :invoice_number)
  end

  def create
    @payment = Payment.new payment_params
    @payment.card_token = params.require(:stripeToken)

    if @payment.save
      redirect_to :payment, success: 'Thank you for your business'
    else
      flash[:errors] = @payment.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def initial_payment_params
    JSON.parse(::Base64.decode64(params[:w])).with_indifferent_access rescue {}
  end

  def payment_params
    params.require(:payment).permit(:description, :amount, :invoice_number)
  end
end
