class IncreaseFromAndToFieldsInOrderHistories < ActiveRecord::Migration[7.0]
  def change
    change_column :order_histories, :from, :string, limit: 50
    change_column :order_histories, :to, :string, limit: 50
  end
end
