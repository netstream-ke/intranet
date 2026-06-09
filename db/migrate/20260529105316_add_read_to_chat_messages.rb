class AddReadToChatMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :chat_messages, :read, :boolean, default: false, null: false
  end
end
