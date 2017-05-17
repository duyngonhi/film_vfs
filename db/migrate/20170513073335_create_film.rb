class CreateFilm < ActiveRecord::Migration[5.0]
  def change
    create_table :films do |t|
      t.string :name_film
      t.datetime :year_screen
      t.integer :rating_film, default: 0
      t.integer :count_like, default: 0
      t.string :picture_film
      t.string :link_trailer
      t.belongs_to :category, index: true
    end
  end
end
