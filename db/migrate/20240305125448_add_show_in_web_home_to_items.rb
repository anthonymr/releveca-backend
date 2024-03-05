class AddShowInWebHomeToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :show_in_web_home, :boolean, default: false
    add_column :items, :show_in_web_home_order, :integer
    add_column :items, :show_in_web_home_tags, :string
  end
end
