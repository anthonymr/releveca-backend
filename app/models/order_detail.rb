class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :currency

  validates :qty, :unit_price, :total_price, presence: true
  validates :qty, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :unit_price, :total_price, numericality: { greater_than: 0 }
  validates :order, :item, :currency, presence: true

  before_create do |new_order_detail|
    new_order_detail.unit_price = new_order_detail.item&.price
    new_order_detail.total_price = new_order_detail.qty * new_order_detail.unit_price
  end
end
