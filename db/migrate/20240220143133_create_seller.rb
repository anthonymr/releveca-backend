class CreateSeller < ActiveRecord::Migration[7.0]
  def change
    create_table :sellers do |t|
      t.string :code
      t.string :name
      t.string :seller_type
      t.string :rif
      t.string :address
      t.string :phones
      t.string :commission
      t.string :sale_commision

      t.timestamps
    end
  end
end
