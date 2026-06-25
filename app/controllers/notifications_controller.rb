class NotificationsController < ApplicationController

before_action :require_login

  def index
  @notifications = current_user.user_notifications.order(created_at: :desc)

  current_user.user_notifications.update_all(read: true)
end
end