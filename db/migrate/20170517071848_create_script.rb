class CreateScript < ActiveRecord::Migration[5.0]
  def change
    create_table :scripts do |t|
      t.string :title
      t.string :content
      t.integer :status, default: 0
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
