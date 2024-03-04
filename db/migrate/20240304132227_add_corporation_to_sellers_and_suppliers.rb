class AddCorporationToSellersAndSuppliers < ActiveRecord::Migration[7.0]
  def change
    add_reference :sellers, :corporation, foreign_key: true
    add_reference :suppliers, :corporation, foreign_key: true
  end
end
