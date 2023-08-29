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
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def check
    if @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postage = 800
      @cart_items = current_customer.cart_items.all
      @total_price = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
    else
      flash[:notice] = "お支払い方法を選択してください。"
      render :new
    end
  end


  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
