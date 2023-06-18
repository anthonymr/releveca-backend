class CreateJoinTableCorporationUser < ActiveRecord::Migration[7.0]
  def change
    create_table :corporations_users, id: false do |t|
      t.bigint :corporation_id
      t.bigint :user_id
    end

    add_index :corporations_users, :corporation_id
    add_index :corporations_users, :user_id
  end
end
