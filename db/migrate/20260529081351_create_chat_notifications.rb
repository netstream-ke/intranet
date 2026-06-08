class CreateChatNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :actor_id
      t.string :message
      t.boolean :read

      t.timestamps
    end
  end
end
