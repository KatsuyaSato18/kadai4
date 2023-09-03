class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @orders = Order.all.order('created_at DESC')
    @orders = @orders.page(params[:page])

  end

  private
  def authenticate_admin!
    unless admin_signed_in?  # Devise提供のヘルパー
      redirect_to root_path
    end
  end

end
