class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :grill,
    :line, :juice,:cashier, :baking, :coldpress, :status])
    devise_parameter_sanitizer.permit(:edit, keys: [:name, :grill,
    :line, :juice,:cashier, :baking, :coldpress, :status])
  end
  def letin
    redirect_to new_user_session_url unless user_signed_in?
  end

end
