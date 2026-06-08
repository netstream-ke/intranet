class AddUserToNews < ActiveRecord::Migration[8.0]
def change
  add_reference :news, :user, null: true, foreign_key: true
end
end
