class DonationsController < ApplicationController

  def new
    @nonprofit = Nonprofit.find(params[:nonprofit_id])
  end

  def create
    @amount = params[:amount].to_i * 100
    @nonprofit = Nonprofit.find(params[:nonprofit_id])
    @donation = Donation.create(nonprofit_id: @nonprofit.id, amount: @amount, customer_id: Customer.find_or_create_by(email: params[:stripeEmail]).id)
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => @nonprofit.name,
      :currency    => 'usd',
    )
    flash[:notice] = "Donation accepted!"
    redirect_to nonprofits_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to nonprofits_path
  end
end
