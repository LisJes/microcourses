class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #LIJ: Added new paramteres to the devise user forms. Now those need to be configured
  before_action :configure_permitted_parameters, if: :devise_controller?

private
  def configure_permitted_parameters
  	devise_parameter_sanitizer.permit(:sign_up) do |user|
  		user.permit(:email, :password, :password_confirmation, :first_name, :last_name, :username)
    end
    devise_parameter_sanitizer.permit(:account_update) do |user|
  		user.permit(:email, :password, :password_confirmation, :current_password, :first_name, :last_name, :username)
    end
  end
end
