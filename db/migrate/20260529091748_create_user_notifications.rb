class CreateUserNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :user_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :actor_id
      t.string :message
      t.boolean :read
      t.references :notifiable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
