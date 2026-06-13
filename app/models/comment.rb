class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user

  # Threading
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies,
           class_name: "Comment",
           foreign_key: :parent_id,
           dependent: :destroy

  scope :top_level, -> { where(parent_id: nil) }

  # 🔴 LIVE COMMENTS
  after_create_commit do
    broadcast_append_to "comments_#{task_id}",
      partial: "comments/comment",
      locals: { comment: self }
  end

  after_destroy_commit do
    broadcast_remove_to "comments_#{task_id}"
  end

  after_create_commit :process_mentions_and_tasks

  def process_mentions_and_tasks
  mentioned_users = content.scan(/@(\w+)/).flatten
  mentioned_tasks = content.scan(/#(\w+)/).flatten

  # Notify users
  mentioned_users.each do |username|
    user = User.find_by(name: username)
    next unless user

    Notification.create(
      user: user,
      actor: self.user,
      notifiable: self,
      message: "#{self.user.name} mentioned you in a comment"
    )
  end

  # Link tasks
  mentioned_tasks.each do |task_name|
    task = Task.find_by("title ILIKE ?", "%#{task_name}%")
    next unless task

    TaskMention.create(
      task: task,
      comment: self
    )
  end
end

  # 🔔 MENTIONS
  after_create :notify_mentions

  def notify_mentions
    content.scan(/@(\w+)/).flatten.each do |username|
      user = User.find_by(name: username)

      next unless user

      Notification.create(
        user: user,
        actor: self.user,
        message: "#{self.user.name} mentioned you"
      )
    end
  end
end
