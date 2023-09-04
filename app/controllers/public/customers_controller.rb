class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def withdrawal
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer != current_customer
      redirect_to root_path
      return
    end

    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました."
      redirect_to my_page_path
    else
      flash[:notice] = "会員の更新に失敗しました."
      render :edit
    end
  end

  def quit
    @customer = current_customer
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number,:email, :password, :is_deleted)
  end

end
