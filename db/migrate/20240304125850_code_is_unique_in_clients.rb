class CodeIsUniqueInClients < ActiveRecord::Migration[7.0]
  def change
    # code should be unique in clients by corporation
    add_index :clients, [:code, :corporation_id], unique: true
  end
end
