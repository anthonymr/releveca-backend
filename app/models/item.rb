class Item < ApplicationRecord
  belongs_to :corporation

  validates :code, presence: true, length: { maximum: 50 }
  validates :name, presence: true, length: { maximum: 50 }
  validates :model, length: { maximum: 50 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :unit, presence: true, length: { maximum: 10 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :index, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :corporation, presence: true
end
