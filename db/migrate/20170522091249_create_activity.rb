class CreateActivity < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.belongs_to :user, index: true
      t.integer :target_id
      t.string :action_type
      t.timestamps null: false
    end
  end
end
