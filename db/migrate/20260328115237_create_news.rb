class CreateNews < ActiveRecord::Migration[7.0]
  def change
    create_table :news do |t|
      t.string :title
      t.string :category   # main_headline, brief, comment
      t.string :writer
      t.text :content

      t.timestamps
    end
  end
end