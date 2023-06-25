class CreateOrderDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :order_details do |t|
      t.integer :qty, null: false, unsigned: true
      t.decimal :unit_price, null: false, unsigned: true, precision: 10, scale: 2
      t.decimal :total_price, null: false, unsigned: true, precision: 10, scale: 2
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.references :currency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
