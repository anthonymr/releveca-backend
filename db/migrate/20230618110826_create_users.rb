class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :user_name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
