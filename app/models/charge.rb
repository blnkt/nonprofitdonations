 class Charge < ActiveRecord::Base
  before_create :payment_details

private

  def payment_details
    @amount = 500

    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Non-Profit Donator',
      :currency    => 'usd'
    )
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
