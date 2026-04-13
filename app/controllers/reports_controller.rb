class ReportsController < ApplicationController

  def index
    @tasks = Task.completed

    @total_tasks = @tasks.count

    @total_time = @tasks.sum do |task|
      task.duration || 0
    end
    @tasks_by_status = {
  not_done: Task.not_done.count,
  ongoing: Task.ongoing.count,
  completed: Task.completed.count
}

    @total_hours = (@total_time / 3600.0).round(2)

    @average_time = if @tasks.count > 0
      (@total_time / @tasks.count / 60.0).round(2)
    else
      0
    end
  end
  

end