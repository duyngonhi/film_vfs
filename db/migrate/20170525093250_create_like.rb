class CreateLike < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.integer :like_user_id
      t.integer :like_film_id
      t.timestamps null: false
    end
    add_index :likes, :like_user_id
    add_index :likes, :like_film_id
    add_index :likes, [:like_user_id, :like_film_id], unique: true
  end
end
