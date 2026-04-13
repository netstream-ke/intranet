class SessionsController < ApplicationController

  before_action :redirect_if_logged_in, only: [:new]

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
      redirect_to edit_password_path(user)
    else
      redirect_to tasks_path, notice: "Logged in successfully"
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
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out"
  end

end
