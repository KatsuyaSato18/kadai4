class Public::OrdersController < ApplicationController
  before_action :set_order, only: [:update]

  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
    @order.postage = 800
    @order.total_price = params[:order][:total_price]

    if @order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart.amount
        order_detail.price = cart.item.price
        order_detail.save
      end
      cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      render :new
    end
  end

  def thanks
  end

  def check
    if params[:order] && params[:order][:payment_method]
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      @order.postage = 800
      @cart_items = current_customer.cart_items.all
      @total_price = @cart_items.inject(0) { |sum, item| sum + item.sum_price }
      @total_price += @order.postage
    # ビューに移動する処理を書く
    else
      flash[:notice] = "お支払い方法を選択してください。"
      redirect_to new_order_path # または適当なパス
    end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc).page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @total_price = @order.total_price
    unless @order.customer_id == current_customer.id
      flash[:notice] =  "不正なアクセスです。"
      redirect_to root_path
      return
    end
  end



  private

  def order_params
    params.fetch(:order, {}).permit(:postal_code, :address, :name, :payment_method)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
