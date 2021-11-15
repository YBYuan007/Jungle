class Admin::SalesController < ApplicationController

  http_basic_authenticate_with name: ENV["BASIC_AUTH_USERNAME"], password: ENV["BASIC_AUTH_PASSWORD"]

  def index 
    @sales = Sale.all
  end 
  
  def new
    @sale = Sale.new
  end

  def create 
    @sale = Sale.new(sale_params)

    if @sale.save
      redirect_to [:admin, :sales], notice: 'New Sale created!'
    else
      render :new
    end
  end 

  private

  def category_params
    params.require(:sale).permit(
      :name, 
      :percent_off,
      :starts_on,
      :ends_on
    )
  end



end
