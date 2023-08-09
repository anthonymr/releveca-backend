class PaymentCondition < ApplicationRecord
  belongs_to :corporation
  has_many :orders, dependent: :restrict_with_error

  validates :code, presence: true, length: { maximum: 10 }
  validates :description, presence: true, length: { maximum: 50 }
  validates :days, presence: true, numericality: { only_integer: true }
  validates :index, numericality: { only_integer: true }, allow_nil: true
  validates :corporation, presence: true

  def mine?
    corporation == Current.corporation
  end
end
