class AddSellerToClient < ActiveRecord::Migration[7.0]
  def change
    add_column :clients, :seller_code, :string
  end
end
