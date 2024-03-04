class CodeIsUniqueInSeller < ActiveRecord::Migration[7.0]
  def change
    add_index :sellers, :code, unique: true
  end
end
