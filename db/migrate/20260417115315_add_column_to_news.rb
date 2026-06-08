class AddColumnToNews < ActiveRecord::Migration[8.0]
  def change
    add_column :news, :column, :integer
  end
end
