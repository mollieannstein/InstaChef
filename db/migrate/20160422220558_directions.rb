class Directions < ActiveRecord::Migration
  def change
    create_table :directions do |t|
      t.text :step
      t.integer :recipe_id

      t.timestamps null: false
    end
  end
end
