class TaskMention < ApplicationRecord
  belongs_to :task
  belongs_to :comment
end
