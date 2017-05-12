class CrateFilm < ActiveRecord::Migration[5.0]
  def change
    create_table :films do |t|
      t.string :name_film
      t.datetime :year_screen
      t.string :rating_film
      t.integer :count_like
      t.string :picture_film
      t.string :link_trailer
    end
  end
end
