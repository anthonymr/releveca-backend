class AddStatusToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :status, :string, default: 'disabled', null: false, limit: 20
  end
end
