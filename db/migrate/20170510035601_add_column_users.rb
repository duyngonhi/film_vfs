class AddColumnUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fullname, :string
    add_column :users, :birthday, :date
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :role, :string
  end
end
