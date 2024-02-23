class AddSupplierToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :supplier_code, :string
  end
end
