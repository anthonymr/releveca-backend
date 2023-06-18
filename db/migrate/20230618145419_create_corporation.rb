class CreateCorporation < ActiveRecord::Migration[7.0]
  def change
    create_table :corporations do |t|
      t.string :name, null: false, index: { unique: true }, limit: 50
      t.string :rif, null: false, index: { unique: true }, limit: 15
      t.string :address, null: false, limit: 100
      t.string :phone, limit: 15
      t.string :email, limit: 50
      t.string :website, limit: 50

      t.timestamps
    end
  end
end
