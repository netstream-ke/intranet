class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

def require_login
  redirect_to login_path unless current_user
end

  def authenticate_user
    redirect_to login_path unless current_user
  end

  def require_admin
    redirect_to admin_dashboard_path unless current_user&.admin?
  end

  before_action :set_last_seen

def set_last_seen
  return unless current_user

  current_user.update(
    online: true,
    last_seen_at: Time.current
  )
end

before_action :load_notifications

def load_notifications
  return unless current_user

  @notifications = current_user.user_notifications
                               .order(created_at: :desc)
                               .limit(10)

  @unread_count = current_user.user_notifications.unread.count
end
end
