class CodeIsUniqueInSuppliersAndSellers < ActiveRecord::Migration[7.0]
  def change
    remove_index :suppliers, :code
    remove_index :sellers, :code

    add_index :suppliers, [:code, :corporation_id], unique: true
    add_index :sellers, [:code, :corporation_id], unique: true
  end
end
