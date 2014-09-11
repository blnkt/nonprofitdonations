 class Customer < ActiveRecord::Base
  before_create :payment_details

private

  def payment_details
    @amount = 500

    customer = Stripe::Customer.create(
      :email => self,
      :card  => self[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Non-Profit Donator',
      :currency    => 'usd'
    )
    self.update(email: customer[:email], card: customer[:card])
    charge.create(customer: self.id, amount: @amount, description: charge[:description], currency: charge[:currency])
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
