class NotificationsController < ApplicationController
 def index
  current_user.notifications.update_all(read: true)
  @notifications = current_user.notifications
end
end


