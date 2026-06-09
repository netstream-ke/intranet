class OverdueTasksJob < ApplicationJob
  queue_as :default

  def perform
    Task.where("due_date < ?", Date.today).each do |task|
      TaskMailer.task_overdue(task).deliver_now
    end
  end
end
