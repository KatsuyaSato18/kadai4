# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_customer, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

   protected

  def reject_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password])
        if @customer.is_deleted == true
          flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
          redirect_to new_customer_registration_path
        end
      else
        if params[:customer][:password].blank? || params[:customer][:email].blank?
          flash[:notice] = "項目を入力してください。"
        else
          flash[:notice] = "パスワードが違います。"
        end
      end
    else
      flash[:notice] = "該当するユーザーが見つかりません。"
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
