class AddParentIdToComments < ActiveRecord::Migration[8.0]
def change
  unless column_exists?(:comments, :parent_id)
    add_column :comments, :parent_id, :integer
  end
end
end