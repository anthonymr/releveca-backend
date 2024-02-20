class AddSellerToWarranties < ActiveRecord::Migration[7.0]
  def change
    add_reference :warranties, :seller, null: false, foreign_key: true
  end
end
