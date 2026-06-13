class Notification < ApplicationRecord
  belongs_to :user      # receiver
  belongs_to :actor, class_name: "User" # sender
  belongs_to :notifiable, polymorphic: true
end
