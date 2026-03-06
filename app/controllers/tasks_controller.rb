class TasksController < ApplicationController

  before_action :authenticate_user

  def index
    @tasks = Task.all

    if params[:search]
      @tasks = @tasks.where("title ILIKE ?", "%#{params[:search]}%")
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

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

  private

  def task_params
    params.require(:task).permit(:title,:description,:status,:priority,:due_date,:user_id)
  end
end