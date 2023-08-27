class Public::OrdersController < ApplicationController
  before_action :set_order, only: [:update]

  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_detail = OrderItem.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.order_amount = cart.amount
        order_detail.total_price = cart.item.price
        order_detail.save
      end
      flash[:notice] = "注文が完了しました。"
      redirect_to orders_thanks_path
    else
      render :new
    end
  end

  def check
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    @order.postage = 800
    @cart_items = current_customer.cart_items.all
    redirect_to orders_check_path
  end


  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
