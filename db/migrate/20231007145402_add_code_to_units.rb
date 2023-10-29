class AddCodeToUnits < ActiveRecord::Migration[7.0]
  def change
    add_column :units, :code, :string
  end
end
