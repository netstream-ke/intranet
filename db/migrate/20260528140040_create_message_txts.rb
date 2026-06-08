class CreateMessageTxts < ActiveRecord::Migration[8.0]
  def change
    create_table :message_txts do |t|
      t.references :conversation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
