class AddCorporationReferenceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :corporation, null: false, foreign_key: true
  end
end
