class UserNotification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true, optional: true

  scope :unread, -> { where(read: false) }
end
