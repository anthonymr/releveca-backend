class AddValidationsToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :name, :string, null: false, limit: 50
    change_column :users, :last_name, :string, null: false, limit: 50
    change_column :users, :user_name, :string, null: false, limit: 50
    change_column :users, :email, :string, null: false, limit: 50
    change_column :users, :password_digest, :string, null: false

    add_index :users, :email, unique: true
    add_index :users, :user_name, unique: true
  end
end
