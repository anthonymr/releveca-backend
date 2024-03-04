class CodeIsUniqueInClients < ActiveRecord::Migration[7.0]
  def change
    add_index :clients, :code, unique: true
  end
end
