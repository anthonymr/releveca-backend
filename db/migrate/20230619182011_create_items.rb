class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :code, null: false, limit: 50
      t.string :name, null: false, limit: 50
      t.string :model, limit: 50
      t.decimal :stock, default: 0, precision: 10, scale: 2, null: false
      t.string :unit, limit: 10, null: false, default: 'UND'
      t.decimal :price, default: 0, precision: 10, scale: 2, null: false
      t.integer :index
      t.references :corporation, null: false, foreign_key: true

      t.timestamps
    end

    add_index :items, %i[corporation_id code], unique: true
  end
end
