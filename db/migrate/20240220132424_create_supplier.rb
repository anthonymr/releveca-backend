class CreateSupplier < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :code
      t.string :name
      t.string :inactive
      t.string :zone
      t.string :address
      t.string :phones
      t.string :type
      t.string :rif
      t.string :email
      t.string :city
      t.string :zip

      t.timestamps
    end
  end
end
