class CodeIsUniqueInItems < ActiveRecord::Migration[7.0]
  def change
    add_index :items, :code, unique: true
  end
end
