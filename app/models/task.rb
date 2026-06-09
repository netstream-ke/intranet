class Task < ApplicationRecord
  belongs_to :user

  belongs_to :assigned_to,
             class_name: "User",
             optional: true

  has_many :comments, dependent: :destroy
  has_many_attached :files

validates :user, presence: true

  enum :status, {
    not_done: 0,
    ongoing: 1,
    completed: 2
  }

  enum :priority, {
    low: 0,
    medium: 1,
    high: 2
  }

  def due_in_days
    return nil unless due_date

    (due_date.to_date - Date.today).to_i
  end

  validates :title, presence: true

  # Calculate task duration
  def duration
    return nil unless started_at && completed_at

    (completed_at - started_at).to_i
  end

  def duration_in_minutes
    return nil unless duration

    (duration / 60.0).round(2)
  end
end
