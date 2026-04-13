class CreateTaskMentions < ActiveRecord::Migration[8.0]
  def change
    create_table :task_mentions do |t|
      t.references :task, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
