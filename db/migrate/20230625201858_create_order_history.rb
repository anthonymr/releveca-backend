class CreateOrderHistory < ActiveRecord::Migration[7.0]
  def change
    create_table :order_histories do |t|
      t.string :from, null: false, limit: 10
      t.string :to, null: false, limit: 10
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
