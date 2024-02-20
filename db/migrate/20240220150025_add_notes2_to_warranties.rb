class AddNotes2ToWarranties < ActiveRecord::Migration[7.0]
  def change
    add_column :warranties, :notes2, :text
  end
end
