class AddColorToWarrantyStates < ActiveRecord::Migration[7.0]
  def change
    add_column :warranty_states, :color, :string
  end
end
