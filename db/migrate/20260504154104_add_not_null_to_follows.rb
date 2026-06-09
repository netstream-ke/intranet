class AddNotNullToFollows < ActiveRecord::Migration[8.0]
  def change
change_column_null :follows, :follower_id, false
change_column_null :follows, :followed_id, false
add_index :follows, [ :follower_id, :followed_id ], unique: true
  end
end
