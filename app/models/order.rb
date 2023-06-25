class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :currency
  belongs_to :payment_condition
  belongs_to :corporation

  validates :sub_total, :taxes, :total, presence: true
  validates :approved, inclusion: { in: [true, false] }
  validates :status, inclusion: { in: %w[creado procesado enviado entregado] }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :sub_total, :taxes, :total, :rate, :balance, numericality: { greater_than: 0 }
  validates :total, numericality: { greater_than_or_equal_to: :sub_total }
  validates :total, numericality: { greater_than_or_equal_to: :balance }

  def self.new_with_initials(order_params)
    order = Current.orders.new(order_params)

    order.user = Current.user
    order.corporation = Current.corporation
    order.client = Current.clients.find(order_params[:client_id])
    order.currency = Currency.find(order_params[:currency_id])
    order.payment_condition = Current.payment_conditions.find(order_params[:payment_condition_id])

    order.balance = order_params[:total]
    order.rate = order.currency.rate
    order.status = 'creado'

    order
  rescue ActiveRecord::RecordNotFound
    raise ActiveRecord::RecordNotFound, 'Client or payment condition not found'
  end

  def self.update_with_references(order_params, id)
    order = Current.orders.find(id)

    order.update(client: Current.clients.find(order_params[:client_id]))
    order.update(currency: Currency.find(order_params[:currency_id]))
    order.update(payment_condition: Current.payment_conditions.find(order_params[:payment_condition_id]))

    order.balance = order_params[:total]
    order.rate = order.currency.rate

    order
  rescue ActiveRecord::RecordNotFound
    raise ActiveRecord::RecordNotFound, 'Client or payment condition not found'
  end
end
