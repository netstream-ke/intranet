class UsersController < ApplicationController
  before_action :require_login

  before_action :set_user, only: [
    :show, :edit, :update, :destroy,
    :update_role, :toggle_suspend,
    :edit_password, :update_password
  ]

  before_action :require_admin, only: [
    :index, :new, :create, :destroy,
    :update_role, :toggle_suspend
  ]

  # =========================
  # LIST USERS (ADMIN)
  # =========================
  def index
    @users = User.all
  end

  # =========================
  # CREATE USER
  # =========================
  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_user_params)

    if @user.save
      redirect_to users_path, notice: "User created successfully"
    else
      render :new
    end
  end

  # =========================
  # SHOW PROFILE
  # =========================
  def show
    @articles = @user.news.order(created_at: :desc)
  end

  # =========================
  # EDIT PROFILE
  # =========================
  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile updated"
    else
      render :edit
    end
  end

  # =========================
  # FOLLOW SYSTEM
  # =========================

  # =========================
  # DELETE USER
  # =========================
  def destroy
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

  # =========================
  # ROLE TOGGLE
  # =========================
  def update_role
    ActiveRecord::Base.transaction do
      @user.update!(role: @user.admin? ? "employee" : "admin")
    end

    redirect_to users_path, notice: "User role updated"
  end

  # =========================
  # PASSWORD RESET
  # =========================
  def edit_password
  end

  def update_password
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

  # =========================
  # SUSPEND USER
  # =========================
  def toggle_suspend
    @user.update(suspended: !@user.suspended)
    redirect_to users_path
  end

  # =========================
  # AUTOCOMPLETE
  # =========================
  def autocomplete
    users = User.where("name ILIKE ?", "%#{params[:q]}%").limit(5)
    render json: users.select(:id, :name)
  end

  # =========================
  # PRIVATE
  # =========================
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :bio, :avatar)
  end

  def admin_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Admins only"
    end
  end
end
