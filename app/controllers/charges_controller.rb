class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @amount = 500
    Customer.create(customer_params)
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

private
  def customer_params
    params.require(:customer).permit(:stripeTokenType, :stripeToken, :stripeEmail)
  end
end
