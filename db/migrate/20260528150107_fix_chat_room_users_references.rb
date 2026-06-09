class FixChatRoomUsersReferences < ActiveRecord::Migration[7.0]
  def change
    # only fix chat_room side
    unless column_exists?(:chat_room_users, :chat_room_id)
      add_reference :chat_room_users, :chat_room, null: false, foreign_key: true
    end
  end
end
