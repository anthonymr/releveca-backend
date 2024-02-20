class RenameSupplierType < ActiveRecord::Migration[7.0]
  def change
    rename_column :suppliers, :type, :supplier_type
  end
end
