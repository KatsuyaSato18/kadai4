class Public::OrdersController < ApplicationController
  before_action :set_order, only: [:update]

  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    @customer = current_customer
    @order = Order.new
    @order.postal_code = @customer.postal_code
    @order.address = @customer.address
    @order.name = "#{@customer.last_name} #{@customer.first_name}"
    if @order.save
      # 保存に成功した場合の処理
      redirect_to order_path(@order)
      flash[:notice] = "注文が完了しました。"
    else
      render :new
    end
  end

  def check
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
  end


  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
