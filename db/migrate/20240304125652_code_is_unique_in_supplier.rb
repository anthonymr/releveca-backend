class CodeIsUniqueInSupplier < ActiveRecord::Migration[7.0]
  def change
    add_index :suppliers, :code, unique: true
  end
end
