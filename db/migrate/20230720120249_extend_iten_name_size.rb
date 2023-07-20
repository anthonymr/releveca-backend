class ExtendItenNameSize < ActiveRecord::Migration[7.0]
  def change
    change_column :items, :name, :string, limit: 250
  end
end
