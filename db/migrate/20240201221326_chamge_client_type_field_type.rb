class ChamgeClientTypeFieldType < ActiveRecord::Migration[7.0]
  def change
    change_column :clients, :client_type, :string
  end
end
