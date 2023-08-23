class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: [:update, :destroy, :destroy_all]

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.amount == "個数選択"
      redirect_to item_path(@cart_item.item_id), alert: '個数を選択してください。'
      return
    end
    if @cart_item.save
      flash[:notice] = "カートに商品を追加されました。"
      redirect_to cart_items_path
    else
      flash[:notice] = "カートに商品を追加できませんでした。"
      redirect_to item_path(@cart_item.item_id)
    end
  end


  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "カートに商品を更新しました。"
      redirect_to cart_items_path
    else
      # エラーハンドリング
    end
  end



  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:notice] = "カートの商品を削除しました。"
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    flash[:notice] = "カートの商品を全て削除しました。"
    redirect_to cart_items_path
  end


  private

  def set_cart_item
    @cart_item = current_customer.cart_items.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
