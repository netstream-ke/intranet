class TasksController < ApplicationController

  before_action :authenticate_user

  def index
  @not_done_tasks = Task.not_done.order(created_at: :desc)
  @ongoing_tasks = Task.ongoing.order(created_at: :desc)
  @completed_tasks = Task.completed.order(created_at: :desc)
  end

  def new
    @task = Task.new
  end
  

 def create
  
  @task = Task.new(task_params)

  if @task.save
    respond_to do |format|
      format.html { redirect_to tasks_path }
      format.turbo_stream
    end
  else
    render :new
  end
end

  def edit
    @task = Task.find(params[:id])
  end
  def board
  @not_done = Task.not_done
  @ongoing = Task.ongoing
  @completed = Task.completed
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
    @task = Task.find(params[:id])

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
    Task.find(params[:id]).destroy
    redirect_to tasks_path
  end


  def autocomplete
  tasks = Task.where("title ILIKE ?", "%#{params[:q]}%").limit(5)
  render json: tasks.select(:id, :title)
end

  private

 def task_params
  params.require(:task).permit(
    :title,
    :description,
    :status,
    :priority,
    :due_date,
    :user_id,
    files: []
  )
end
  

end