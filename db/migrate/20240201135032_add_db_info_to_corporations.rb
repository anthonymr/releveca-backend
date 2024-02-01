class AddDbInfoToCorporations < ActiveRecord::Migration[7.0]
  def change
    add_column :corporations, :db_driver, :string
    add_column :corporations, :db_server, :string
    add_column :corporations, :db_name, :string
    add_column :corporations, :db_trusted, :string
  end
end
