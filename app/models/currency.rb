class Currency < ApplicationRecord
  validates :code, presence: true, length: { maximum: 10 }
  validates :description, presence: true, length: { maximum: 50 }
  validates :rate, presence: true, numericality: { greater_than: 0 }
end
