class IncreaseRifAndNitFieldsLengthForClient < ActiveRecord::Migration[7.0]
  def change
    change_column :clients, :rif, :string, limit: 30
    change_column :clients, :nit, :string, limit: 30
  end
end
