class User < ApplicationRecord
has_secure_password
has_many :news
has_one_attached :avatar
has_many :notices, dependent: :destroy
has_many :notifications, dependent: :destroy
has_many :conversation_participants, dependent: :destroy
has_many :conversations, through: :conversation_participants
has_many :chat_room_users
has_many :chat_rooms, through: :chat_room_users
has_many :messages
has_many :chat_messages, dependent: :destroy
has_many :user_notifications

has_many :messages, dependent: :destroy


validates :password,
  length: { minimum: 8 },
  format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+\z/,
    message: "must include at least one lowercase, uppercase letter, and number"
  },
  if: -> { password.present? }

  has_many :tasks

  has_many :assigned_tasks,
           class_name: "Task",
           foreign_key: :assigned_to_id


has_many :tasks, dependent: :destroy
has_many :comments, dependent: :destroy
has_many :notifications, dependent: :destroy

  enum :role, {
    employee: 0,
    manager: 1,
    admin: 2
  }

  after_initialize :set_default_role, if: :new_record?

  def online?
    online
  end

def unread_messages_count
  ChatMessage.joins(:chat_room)
             .joins("INNER JOIN chat_room_users ON chat_room_users.chat_room_id = chat_rooms.id")
             .where(chat_room_users: { user_id: id })
             .where.not(user_id: id)
             .where(read: false)
             .count
end


after_initialize do
  self.suspended = false if self.suspended.nil?
end

after_initialize do
  self.force_password_change = false if self.force_password_change.nil?
end

validates :email, presence: true, uniqueness: true
end

private
  def set_default_role
    self.role ||= :employee
  end
