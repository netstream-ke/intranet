class AddColumnPositionToNews < ActiveRecord::Migration[8.0]
  def change
    add_column :news, :column_position, :integer
  end
end
