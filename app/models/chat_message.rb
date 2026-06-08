class ChatMessage < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  attribute :read, :boolean, default: false
end