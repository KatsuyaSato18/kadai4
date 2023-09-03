class Public::HomesController < ApplicationController
  def top
    @items = Item.all
  end

  def about
    @item = Item.first
  end
end
