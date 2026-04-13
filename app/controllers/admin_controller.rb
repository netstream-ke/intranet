class AdminController < ApplicationController
  before_action :require_admin

  def dashboard
    @total_users = User.count
    @total_tasks = Task.count
    @completed_tasks = Task.completed.count
    @ongoing_tasks = Task.ongoing.count
  end

  def logs
    @logs = AuditLog.all.order(created_at: :desc)
  end

  private

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Admins only"
    end
  end
end