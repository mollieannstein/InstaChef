class Recipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :image_url
      t.integer :servings
      t.string  :prep_time
      t.string  :course

      t.timestamps null: false
    end
  end
end
