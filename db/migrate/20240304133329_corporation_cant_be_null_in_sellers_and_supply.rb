class CorporationCantBeNullInSellersAndSupply < ActiveRecord::Migration[7.0]
  def change
    change_column_null :sellers, :corporation_id, false
    change_column_null :suppliers, :corporation_id, false
  end
end
