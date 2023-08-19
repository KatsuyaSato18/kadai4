class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item =Item.new
  end

  def show
     @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      flash[:notice] = "商品情報を更新しました."
      redirect_to admin_item_path(item)
    else
      render :edit
    end
  end

  private

  def set_item
   @item = Item.find(params[:id])
  end


  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end

end
