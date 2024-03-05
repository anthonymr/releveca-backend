class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.string :color
      t.boolean :show_in_web_home, default: false

      t.timestamps
    end

    add_reference :items, :category, foreign_key: true
  end
end
