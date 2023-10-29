class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :banks do |t|
      t.string :name, null: false
      t.string :number
      t.string :email
      t.string :phone
      t.string :type
      t.string :rif
      t.boolean :active, null: false, default: true

      t.timestamps
    end

    create_table :payments do |t|
      t.decimal :amount, null: false
      t.string :status, null: false, default: 'creado'
      t.string :reference
      t.references :bank, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
