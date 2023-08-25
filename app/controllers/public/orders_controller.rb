class Public::OrdersController < ApplicationController
  before_action :set_order, only: [:update]

  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      # 保存に成功した場合の処理
      redirect_to order_path(@order)
      flash[:notice] = "注文が完了しました。"
    else
      render :new
    end
  end


  private

  def order_params
    params.require(:order).permit(:payment_method)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
