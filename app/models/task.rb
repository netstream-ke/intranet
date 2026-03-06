class Task < ApplicationRecord
  belongs_to :user

  enum status: {
    not_done: 0,
    ongoing: 1,
    completed: 2
  }

  enum priority: {
    low: 0,
    medium: 1,
    high: 2
  }

  validates :title, presence: true
end