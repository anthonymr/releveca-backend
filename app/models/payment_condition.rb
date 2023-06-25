class PaymentCondition < ActiveRecord
  belongs_to :corporation

  validates :code, presence: true, length: { maximum: 10 }
  validates :description, presence: true, length: { maximum: 50 }
  validates :days, presence: true, numericality: { only_integer: true }
  validates :index, numericality: { only_integer: true }, allow_nil: true
  validates :corporation, presence: true
end
