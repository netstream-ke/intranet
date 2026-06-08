class TasksController < ApplicationController

   before_action :authenticate_user
  before_action :set_task, only: [:edit, :update, :destroy]

def index
  visible_tasks = Task.where(
    "user_id = :id OR assigned_to_id = :id",
    id: current_user.id
  )

  @not_done_tasks = visible_tasks.where(status: "not_done")
  @ongoing_tasks = visible_tasks.where(status: "ongoing")
  @completed_tasks = visible_tasks.where(status: "completed")
end

  def new
    @task = Task.new
  end
  

def create
  @task = Task.new(task_params)
  @task.user = current_user

  if @task.save
    redirect_to tasks_path
  else
    render :new
  end
end

def edit
end

def board
  visible_tasks = Task.where(
    "user_id = ? OR assigned_to_id = ?",
    current_user.id,
    current_user.id
  )

  @not_done  = visible_tasks.not_done
  @ongoing   = visible_tasks.ongoing
  @completed = visible_tasks.completed
end

def update_status
  task = Task.find(params[:id])
  new_status = params[:status]

  if new_status == "ongoing" && task.started_at.nil?
    task.started_at = Time.current
  end

  if new_status == "completed" && task.completed_at.nil?
    task.completed_at = Time.current
  end

  task.update(status: new_status)

  head :ok
end

  def update

    new_status = params[:task][:status]

    if new_status == "ongoing" && @task.started_at.nil?
      @task.started_at = Time.current
    end

    if new_status == "completed" && @task.completed_at.nil?
      @task.completed_at = Time.current
    end

    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

def destroy
  @task.destroy
  redirect_to tasks_path
end


  def autocomplete
  tasks = Task.where("title ILIKE ?", "%#{params[:q]}%").limit(5)
  render json: tasks.select(:id, :title)
end

  private

  def set_task
  @task = Task.where(
    "user_id = ? OR assigned_to_id = ?",
    current_user.id,
    current_user.id
  ).find(params[:id])
end

def task_params
  params.require(:task).permit(
    :title,
    :description,
    :status,
    :priority,
    :due_date,
    :user_id,
    :assigned_to_id,
    files: []
  )
end
  

end