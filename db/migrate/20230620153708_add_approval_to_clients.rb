class AddApprovalToClients < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :approval, :boolean, default: false, null: false
  end
end
