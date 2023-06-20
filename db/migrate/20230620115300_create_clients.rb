class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :code, null: false, limit: 50
      t.integer :type, null: false, default: 1, limit: 3
      t.string :name, null: false, limit: 50
      t.string :phone, null: false, limit: 50
      t.string :status, null: false, limit: 50
      t.string :notes, limit: 500
      t.string :address, null: false, limit: 500
      t.string :rif, null: false, index: { unique: true }, limit: 15
      t.boolean :taxpayer
      t.string :nit, limit: 15
      t.string :email, limit: 50
      t.integer :index

      t.references :corporation, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
