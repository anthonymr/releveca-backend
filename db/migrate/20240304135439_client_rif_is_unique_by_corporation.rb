class ClientRifIsUniqueByCorporation < ActiveRecord::Migration[7.0]
  def change
    remove_index :clients, :rif
    add_index :clients, %i[rif corporation_id], unique: true
  end
end
