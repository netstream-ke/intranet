class AddPlacementAndPositionToNews < ActiveRecord::Migration[8.0]
  def up
    add_column :news, :placement, :integer unless column_exists?(:news, :placement)
    add_column :news, :position, :integer, default: 0 unless column_exists?(:news, :position)
  end

  def down
    remove_column :news, :placement if column_exists?(:news, :placement)
    remove_column :news, :position if column_exists?(:news, :position)
  end
end
