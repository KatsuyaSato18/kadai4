class ApplicationController < ActionController::Base

  private
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
        admin_root_path
    else
        root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
        root_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
        root_path
    end
  end

  protected

  def authenticate_customer!
    unless customer_signed_in?
      flash[:notice] = "ログインまたは会員登録してください。"
      redirect_to new_customer_session_path
    end
  end

end
