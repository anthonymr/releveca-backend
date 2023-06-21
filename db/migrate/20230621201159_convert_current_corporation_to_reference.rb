class ConvertCurrentCorporationToReference < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :current_corporation, foreign_key: { to_table: :corporations }
    remove_column :users, :current_corporation, :integer
  end
end
