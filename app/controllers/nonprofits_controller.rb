class NonprofitsController < ApplicationController
  def index
    @nonprofits = Nonprofit.all
  end

  def new
    @nonprofit = Nonprofit.new
    @exp_months =  [
      ['01'],
      ['02'],
      ['03'],
      ['04'],
      ['05'],
      ['06'],
      ['07'],
      ['08'],
      ['09'],
      ['10'],
      ['11'],
      ['12']
    ]
    this_year = Time.new.strftime("%Y").slice(2..3).to_i
    @exp_years = []
    i = 1
    until i > 10
      @exp_years << [(this_year + i).to_s]
      i = i + 1
    end
  end

  def create
    @nonprofit = Nonprofit.new(nonprofit_params)
    if @nonprofit.save
      recipient = Stripe::Recipient.create(
        :name => nonprofit_params[:name],
        :type => nonprofit_params[:type],
        :email => nonprofit_params[:email],
        :card => params[:stripeToken]
      )
      flash[:notice] = "Nonprofit saved!"
      redirect_to nonprofits_path
    end
    rescue Stripe::CardError => e
    flash[:error] = e.message
    render 'new'
  end

  def show
    @nonprofit = Nonprofit.find(params[:id])
  end

  def edit
    @nonprofit = Nonprofit.find(params[:id])
  end

  def update
    @nonprofit = Nonprofit.find(params[:id])
    if @nonprofit.update(nonprofit_params)
      redirect_to nonprofits_path
    else
      render 'edit'
    end
  end

  def destroy
    @nonprofit = Nonprofit.find(params[:id])
    @nonprofit.destroy
  end


private

  def nonprofit_params
    params.require(:nonprofit).permit(:name, :description, :type, :email, :card)
  end
end
