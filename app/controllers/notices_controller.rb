class NoticesController < ApplicationController
  before_action :require_login
  before_action :set_notice, only: [ :show, :destroy ]
  before_action :require_admin, only: [ :new, :create, :destroy ]

  def index
    @notices = Notice.order(created_at: :desc)
  end

  def show
  end

  def new
    @notice = Notice.new
  end

  def create
    @notice = current_user.notices.build(notice_params)

    if @notice.save
      redirect_to notices_path, notice: "Notice uploaded successfully"
    else
      render :new
    end
  end

  def destroy
    @notice.destroy
    redirect_to notices_path, notice: "Notice deleted"
  end

  private

  def set_notice
    @notice = Notice.find(params[:id])
  end

  def notice_params
    params.require(:notice).permit(:title, :document)
  end

  def require_admin
    unless current_user&.admin?
      redirect_to notices_path, alert: "Admins only"
    end
  end
end
