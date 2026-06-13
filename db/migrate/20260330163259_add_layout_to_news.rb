class AddLayoutToNews < ActiveRecord::Migration[8.0]
  def change
    add_column :news, :layout, :string
  end
end
