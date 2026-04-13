class AddIsMainToNews < ActiveRecord::Migration[8.0]
  def change
    add_column :news, :is_main, :boolean
  end
end
