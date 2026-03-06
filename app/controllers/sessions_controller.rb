class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:alert] = "Invalid login"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end