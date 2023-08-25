class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: [:update, :destroy]

  def index
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.inject(0) do |sum, cart_item|
      sum + cart_item.item.price * cart_item.amount
    end
  end

  def create
    # 1. 追加した商品がカート内に存在するかの判別
    existing_cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])

    if existing_cart_item
      # 存在した場合
      # 2. カート内の個数をフォームから送られた個数分追加する
      new_amount = existing_cart_item.amount + params[:cart_item][:amount].to_i
      existing_cart_item.update(amount: new_amount)
      flash[:notice] = "カート内の商品数量を更新しました。"
    else
      # 存在しなかった場合
      # カートモデルにレコードを新規作成する
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.amount.nil? || @cart_item.amount == 0
        flash[:notice] = "個数を選択してください。"
        redirect_to item_path(@cart_item.item_id)
        return
      end
      if @cart_item.save
        flash[:notice] = "カートに商品を追加されました。"
      else
        flash[:notice] = "カートに商品を追加できませんでした。"
        redirect_to item_path(@cart_item.item_id)
        return
      end
    end
    redirect_to cart_items_path
  end



  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(amount: params[:amount])
      flash[:notice] = "数量を更新しました。"
    else
      flash[:notice] = "数量の更新に失敗しました。"
    redirect_to cart_items_path
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
