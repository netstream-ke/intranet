class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def authenticate_user
    redirect_to login_path unless current_user
  end

  def require_admin
    redirect_to dashboard_path unless current_user&.admin?
  end
end