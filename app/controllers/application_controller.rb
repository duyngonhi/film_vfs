class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, :configure_permitted_account_update,
    if: :devise_controller?

  protected

  def checking_admin
    return if current_user.present? && current_user.is_admin?
    redirect_to root_path
  end

  def checking_logged_user
    return if current_user.present?
    redirect_to new_user_session_url
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit :fullname, :birthday, :email, :phone, :address, :role, :password,
        :password_confirmation, :remember_me
    end

    devise_parameter_sanitizer.permit(:sign_in) do |u|
      u.permit :email, :password, :role, :remember_me
    end
  end

  def configure_permitted_account_update
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit :fullname, :birthday, :email, :phone, :address, :role, :password,
        :password_confirmation, :current_password, :remember_me
    end
  end
end
