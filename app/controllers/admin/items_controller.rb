class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items =Item.all
  end

  def new
    @item =Item.new
  end

  def show
  end

  def edit
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
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price)
  end

end
