class AddStoryTypeToNews < ActiveRecord::Migration[8.0]
  def change
    add_column :news, :story_type, :integer
  end
end
