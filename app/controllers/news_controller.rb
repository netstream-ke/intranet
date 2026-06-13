class NewsController < ApplicationController
  require "date"
  before_action :require_login
  before_action :set_news, only: [ :show, :edit, :update, :destroy ]
  before_action :require_admin, only: [ :new, :create, :edit, :update, :destroy, :sort ]

  layout "news"

  # =========================
  # INDEX (HOMEPAGE)
  # =========================
  def index
    @main = News.find_by(story_type: :main)

    @left   = News.left.order(:position)
    @center = News.center.order(:position)
    @right  = News.right.order(:position)
    @grid   = News.grid.order(:position)
  end

  # =========================
  # DRAG & DROP SORT
  # =========================
  def sort
    params[:order].each do |item|
      News.find(item[:id]).update(
        placement: item[:placement],
        position: item[:position]
      )
    end

    head :ok
  end

  # =========================
  # CRUD
  # =========================
  def show
  end

  def new
    @news = News.new(story_type: :main)
  end

  def new_secondary
    @news = News.new(story_type: :secondary)
    render :new
  end

  def new_gallery
    @news = News.new(story_type: :gallery)
    render :new
  end

def create
  @news = News.new(news_params)
  @news.user = current_user   # 🔥 IMPORTANT

  if @news.save
    redirect_to news_path(@news), notice: "Story published"
  else
    render :new
  end
end

  def edit
  end

  def update
    if @news.update(news_params)
      redirect_to news_path(@news), notice: "Story updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_to news_index_path, notice: "Deleted"
  end

  def follow
  current_user.follows.create(followed_id: params[:id])
  redirect_back fallback_location: root_path
end

def unfollow
  current_user.follows.find_by(followed_id: params[:id])&.destroy
  redirect_back fallback_location: root_path
end

  # =========================
  # PRIVATE
  # =========================
  private

  def set_news
    @news = News.find(params[:id])
  end

  def require_admin
    unless current_user&.admin?
      redirect_to news_index_path, alert: "Not authorized"
    end
  end

def news_params
  params.require(:news).permit(
    :title,
    :writer,
    :category,
    :story_type,
    :placement,
    :content,
    media: []
  )
end
end
