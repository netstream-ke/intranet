class UsersController < ApplicationController


before_action :require_login
skip_before_action :require_login, only: [:edit_password, :update_password]



  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "User created successfully"
    else
      render :new
    end
  end

  def update_role
    @user = User.find(params[:id])

    if @user.admin?
      @user.employee!
    else
      @user.admin!
    end

    redirect_to users_path, notice: "User role updated"
  end

  def destroy
    @user = User.find(params[:id])

    if @user == current_user
      redirect_to users_path, alert: "You cannot delete yourself"
    else
      AuditLog.create(
        user: current_user,
        action: "deleted user",
        record_type: "User",
        record_id: @user.id
      )

      @user.destroy
      redirect_to users_path, notice: "User deleted"
    end
  end

  # ✅ SHOW FORM ONLY
  def edit_password
    @user = User.find(params[:id])
  end

  # ✅ HANDLE FORM SUBMISSION
  def update_password
    @user = User.find(params[:id])

    if @user.update(password_params.merge(force_password_change: true))

      UserMailer.password_changed(@user).deliver_now

      AuditLog.create(
        user: current_user,
        action: "changed password",
        record_type: "User",
        record_id: @user.id
      )

      redirect_to users_path, notice: "Password updated"

    else
      render :edit_password
    end
  end

  def toggle_suspend
    user = User.find(params[:id])
    user.update(suspended: !user.suspended)

    redirect_to users_path
  end

  def autocomplete
  users = User.where("name ILIKE ?", "%#{params[:q]}%").limit(5)
  render json: users.select(:id, :name)
end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  private

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Admins only"
    end
  end
end



