class UpdateClientFieldsLength < ActiveRecord::Migration[7.0]
  def change
    change_column :clients, :code, :string, limit: 200, null: false
    change_column :clients, :name, :string, limit: 200, null: false
    change_column :clients, :phone, :string, limit: 200, null: false
    change_column :clients, :status, :string, limit: 200, null: false
    change_column :clients, :email, :string, limit: 200
    change_column :clients, :rif, :string, limit: 200, null: false
    change_column :clients, :nit, :string, limit: 200
  end
end
