class Public::HomesController < ApplicationController
  def top
  end

  def about
    @item = Item.first
  end
end
