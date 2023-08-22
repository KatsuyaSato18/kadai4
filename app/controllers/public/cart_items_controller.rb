class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: [:create]



  def index
    @cart_items = current_customer.cart_items
  end

  private

  def set_cart_item
    @cart_item = current_customer.cart_items.find(params[:id])
  end

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

end
