class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :code, null: false, limit: 10
      t.string :description, null: false, limit: 50
      t.decimal :rate, null: false, precision: 10, scale: 4
      t.integer :index

      t.timestamps
    end
  end
end
