class Ingredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :item
      t.integer :recipe_id

      t.timestamps null: false
    end
  end
end
