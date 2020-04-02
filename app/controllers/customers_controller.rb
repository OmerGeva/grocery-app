class CustomersController < ApplicationController
  def new
    @customer = Customer.new()

    authorize @customer
  end
  def create
    @customer = Customer.new(customer_params)
    @customer.user = current_user

    if @customer.save
      redirect_to supermarket_path(Supermarket.find_by(name: 'Shufersal'))
    else
      render :new
    end

    authorize @customer
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :phone_number, :address)
  end
end
