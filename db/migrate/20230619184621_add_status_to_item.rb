class AddStatusToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :status, :string, default: 'enabled', null: false, limit: 20
  end
end
