module CommentsHelper
  def format_content(text)
    text
      .gsub(/@(\w+)/) do |username|
        user = User.find_by(name: username)
        user ? link_to("@#{username}", "#", class: "mention") : "@#{username}"
      end
      .gsub(/#(\w+)/) do |task_name|
        task = Task.find_by("title ILIKE ?", "%#{task_name}%")

        if task
          link_to "##{task_name}", tasks_path(task_id: task.id), class: "task-tag"
        else
          "##{task_name}"
        end
      end
      .html_safe
  end
end
