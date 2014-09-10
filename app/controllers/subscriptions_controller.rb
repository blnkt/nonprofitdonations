class SubscriptionsController < ApplicationController

  def new
    @nonprofit = Nonprofit.find(params[:nonprofit_id])
    @subscription = Subscription.new
    @plans = Plan.where(nonprofit_id: params[:nonprofit_id])
  end

  def create
    @plan = Plan.find(params[:plan_id])
    @nonprofit = Nonprofit.find(params[:nonprofit_id])
    @subscription = Subscription.create(nonprofit_id: @nonprofit.id, plan_id: @plan.id, customer_id: Customer.find_or_create_by(email: params[:stripeEmail]).id)
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :plan => @plan.name.parameterize,
      :card  => params[:stripeToken]
    )

    flash[:notice] = "Subscription accepted!"
    redirect_to nonprofits_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to nonprofits_path
  end
end
