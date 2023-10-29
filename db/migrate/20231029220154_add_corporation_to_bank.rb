class AddCorporationToBank < ActiveRecord::Migration[7.0]
  def change
    add_reference :banks, :corporation, null: false, foreign_key: true
  end
end
