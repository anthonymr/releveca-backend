class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :currency
  belongs_to :payment_condition

  validates :sub_total, :taxes, :total, :rate, :status, :index, :balance, presence: true
  validates :approved, inclusion: { in: [true, false] }
  validates :status, inclusion: { in: %w[creado procesado enviado entregado] }
  validates :index, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :sub_total, :taxes, :total, :rate, :balance, numericality: { greater_than: 0 }
  validates :total, numericality: { greater_than_or_equal_to: :sub_total }
  validates :total, numericality: { greater_than_or_equal_to: :balance }
  validates :total, numericality: { equal_to: :sub_total + :taxes }
end
