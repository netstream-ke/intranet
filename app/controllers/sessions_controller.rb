class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [ :new ]

  def new
  end

def create
  user = User.find_by(email: params[:email])

  if user&.authenticate(params[:password])

    if user.suspended?
      redirect_to login_path, alert: "Account suspended"
      return
    end

    session[:user_id] = user.id

    if user.force_password_change
      redirect_to edit_password_user_path(user)
    else
      redirect_to tasks_path, notice: "Logged in successfully"
    end

    user.update(online: true, last_seen_at: Time.current)

    # 🔔 NEW CHAT NOTIFICATIONS
    user.chat_rooms.each do |room|
      other_user = room.users.where.not(id: user.id).first

      next unless other_user

      UserNotification.create!(
        user: user,
        actor_id: other_user.id,
        message: "Chat available with #{other_user.name}",
        notifiable: room,
        read: false
      )
    end

  else
    flash.now[:alert] = "Invalid email or password"
    render :new
  end
end

  def redirect_if_logged_in
  redirect_to tasks_path if current_user
end

 def destroy
  current_user&.update(online: false)

  reset_session

  redirect_to login_path, notice: "Logged out"
end
end
