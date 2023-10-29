class Payment < ApplicationRecord
  belongs_to :bank
  belongs_to :order

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[creado aprobado rechazado] }
end