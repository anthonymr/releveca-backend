class CreateWarranty < ActiveRecord::Migration[7.0]
  def change
    create_table :warranties do |t|
      t.decimal :quantity, null: false, default: 0.0, precision: 10, scale: 2
      t.string :notes, limit: 500
      t.string :status, null: false, limit: 50

      t.references :client, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :corporation, null: false, foreign_key: true

      t.timestamps
    end
  end
end