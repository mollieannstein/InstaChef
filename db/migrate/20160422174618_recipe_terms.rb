class RecipeTerms < ActiveRecord::Migration
  def change
    create_table :recipe_terms do |t|
      t.integer :recipe_id
      t.integer :procedure_id

      t.timestamps null: false
    end
  end
end
