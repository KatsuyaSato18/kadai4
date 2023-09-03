class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @total_price = @order.total_price
  end

  private

  def authenticate_admin!
    unless admin_signed_in?  # Devise提供のヘルパー
      redirect_to root_path
    end
  end
end
