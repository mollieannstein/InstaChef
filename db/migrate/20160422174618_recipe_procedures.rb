class RecipeProcedures < ActiveRecord::Migration
  def change
    create_table :recipe_procedures do |t|
      t.integer :recipe_id
      t.integer :procedure_id

      t.timestamps null: false
    end
  end
end
