class AddCurrentCorporationToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :current_corporation, :integer
  end
end
