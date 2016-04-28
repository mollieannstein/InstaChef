class Procedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.string :term
      t.string :past_tense_term
      t.text :instructions
      t.string :youtube_url
      t.string :gif_url

      t.timestamps null: false
    end
  end
end
