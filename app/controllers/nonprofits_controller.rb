class NonprofitsController < ApplicationController
  def index
    @nonprofits = Nonprofit.all
  end

  def new
    @nonprofit = Nonprofit.new
  end

  def create
    @nonprofit = Nonprofit.new(nonprofit_params)
    if @nonprofit.save
      flash[:notice] = "Nonprofit saved!"
      redirect_to nonprofits_path
    else
      render 'new'
    end
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
    params.require(:nonprofit).permit(:name)
  end
end
