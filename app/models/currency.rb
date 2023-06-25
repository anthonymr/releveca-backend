class Currency < ApplicationRecord
  has_many :corporations, foreign_key: 'base_currency_id', dependent: :restrict_with_error
  has_many :corporations, foreign_key: 'default_currency_id', dependent: :restrict_with_error
  has_many :orders, dependent: :restrict_with_error
  has_many :order_details, dependent: :restrict_with_error

  validates :code, presence: true, length: { maximum: 10 }
  validates :description, presence: true, length: { maximum: 50 }
  validates :rate, presence: true, numericality: { greater_than: 0 }
end
