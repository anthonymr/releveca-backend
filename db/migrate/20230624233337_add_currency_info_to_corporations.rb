class AddCurrencyInfoToCorporations < ActiveRecord::Migration[7.0]
  def change
    add_reference :corporations, :default_currency, foreign_key: { to_table: :currencies }
    add_reference :corporations, :base_currency, foreign_key: { to_table: :currencies }
  end
end
