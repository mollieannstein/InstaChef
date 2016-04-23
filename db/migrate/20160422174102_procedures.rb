class Procedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.string :term
      t.text :instructions

      t.timestamps null: false
    end
  end
end
