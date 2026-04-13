class NewsController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]



    layout "news"

 def index
  @main = News.find_by(is_main: true)
  @articles = News.others
end

  def show
    @news = News.find(params[:id])
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # POST /news
def create
  @news = News.new(news_params)

  if @news.is_main?
    News.update_all(is_main: false)   # 👈 HERE
  end

  if @news.save
    redirect_to news_index_path, notice: "Story published successfully."
  else
    render :new
  end
end

  # GET /news/:id/edit
  def edit
  @news = News.find(params[:id])   # 🔥 THIS LINE IS REQUIRED
end

  # PATCH/PUT /news/:id
def update
  @news = News.find(params[:id])

  if @news.update(news_params)
    redirect_to @news, notice: "Updated successfully"
  else
    render :edit
  end
end

  # DELETE /news/:id
  def destroy
    @news.destroy
    redirect_to news_index_path, notice: "News item deleted successfully."
  end

  private

  def set_news
    @news = News.find(params[:id])
  end

def news_params
  params.require(:news).permit(:title, :category, :writer, :content, images: [])
end

def require_login
  unless current_user
    redirect_to login_path, alert: "Please log in to access news"
  end
end

  def require_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Admins only"
    end
  end
end
