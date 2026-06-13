class TaskMailer < ApplicationMailer

def task_assigned(task)
  return unless task.user.present?

  @task = task
  mail(to: task.user.email, subject: "New Task Assigned")
end

def task_overdue(task)
  return unless task.user.present?

  @task = task
  mail(to: task.user.email, subject: "Task Overdue")
end