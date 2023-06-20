class RenameClientTypeColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :clients, :type, :client_type
  end
end
