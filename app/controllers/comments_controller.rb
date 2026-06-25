class CommentsController < ApplicationController
  before_action :require_login
  before_action :require_admin, only: [ :destroy ]

def create
  @task = Task.find(params[:task_id])

  @comment = @task.comments.build(comment_params)
  @comment.user = current_user
  @comment.parent_id = params[:comment][:parent_id] # 🔥 important

  if @comment.save
    redirect_to tasks_path
  else
    redirect_to tasks_path, alert: "Failed to comment"
  end
end

def typing
  ActionCable.server.broadcast(
    "comments_#{params[:task_id]}",
    { typing: "#{current_user.email} is typing..." }
  )
end

 def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

def destroy
  @comment = Comment.find(params[:id])

  if current_user&.admin? || @comment.user == current_user
    @comment.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path, notice: "Comment deleted" }
    end
  else
    redirect_to tasks_path, alert: "Not authorized"
  end
end

private

def comment_params
  params.require(:comment).permit(:content, :parent_id)
end
end