class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :sub_total, null: false
      t.decimal :taxes, null: false
      t.decimal :total, null: false
      t.decimal :rate, null: false
      t.string :status, null: false, default: 'creado'
      t.boolean :approved, null: false, default: false
      t.integer :index
      t.decimal :balance, null: false, default: :total
      t.references :payment_condition, nill: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :currency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
