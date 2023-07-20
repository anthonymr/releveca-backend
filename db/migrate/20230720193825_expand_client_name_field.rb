class ExpandClientNameField < ActiveRecord::Migration[7.0]
  def change
    change_column :clients, :name, :string, limit: 250
  end
end
