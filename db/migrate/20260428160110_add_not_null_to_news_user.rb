class AddNotNullToNewsUser < ActiveRecord::Migration[8.0]
def change
  change_column_null :news, :user_id, false
end
end
