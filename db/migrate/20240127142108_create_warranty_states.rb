class CreateWarrantyStates < ActiveRecord::Migration[7.0]
  def change
    create_table :warranty_states do |t|
      t.string :name, null: false, limit: 50

      t.timestamps
    end
  end
end
