class ChatRoom < ApplicationRecord
has_many :chat_room_users, dependent: :destroy 
has_many :users, through: :chat_room_users 
has_many :chat_messages, dependent: :destroy

  def self.between(user1, user2)
    joins(:chat_room_users)
      .where(chat_room_users: { user_id: [user1.id, user2.id] })
      .group("chat_rooms.id")
      .having("COUNT(chat_room_users.user_id) = 2")
      .first
  end
end