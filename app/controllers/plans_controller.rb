class PlansController < ApplicationController
  def index
    @nonprofit = Nonprofit.find(params[:nonprofit_id])
    @plans = Plan.all
  end
  def new
    @plan = Plan.new
    @nonprofit = Nonprofit.new
    @nonprofit = Nonprofit.find(params[:nonprofit_id])
    @intervals =  [
      ['daily'],
      ['week'],
      ['month'],
      ['year']
    ]
  end

  def create
    @nonprofit = Nonprofit.find(params[:plan][:nonprofit_id])
    @plan = Plan.new(plan_params)
    @plan.stripeid = @plan.name.parameterize
    if @plan.save
      Stripe::Plan.create(
        :amount => @plan.amount.to_i * 100,
        :interval => @plan.interval,
        :name => @plan.name,
        :currency => 'usd',
        :id => @plan.stripeid
      )
      flash[:notice] = "Plan created!"
      redirect_to nonprofit_plans_path(@nonprofit)
    else
      flash[:error] = "Something went wrong"
      render'new'
    end
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to nonprofits_path
  end

private

  def plan_params
    params.require(:plan).permit(:amount, :interval, :name, :nonprofit_id)
  end
end
