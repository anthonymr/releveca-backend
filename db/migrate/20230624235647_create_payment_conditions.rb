class CreatePaymentConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :payment_conditions do |t|
      t.string :code, null: false, limit: 10
      t.string :description, null: false, limit: 50
      t.integer :days, null: false
      t.integer :index
      t.references :corporation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
