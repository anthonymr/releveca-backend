class OrderDetail < ApplicationController
  belongs_to :order
  belongs_to :item
  belongs_to :currency

  validates :qty, :unit_price, :total_price, presence: true
  validates :qty, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :unit_price, :total_price, numericality: { greater_than: 0 }
  validates :order, :item, :currency, presence: true
end
