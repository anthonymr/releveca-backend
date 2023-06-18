class AddStatusToCorporation < ActiveRecord::Migration[7.0]
  def change
    add_column :corporations, :status, :string, default: 'enabled', null: false, limit: 20
  end
end
