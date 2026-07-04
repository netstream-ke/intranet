class UserNotification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, class_name: "User", foreign_key: :actor_id, optional: true
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read: false) }

  def chat_room
    notifiable if notifiable.is_a?(ChatRoom)
  end
end
