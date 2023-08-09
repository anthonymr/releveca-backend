class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :currency
  belongs_to :payment_condition
  belongs_to :corporation
  has_many :order_details, dependent: :destroy
  has_many :order_histories, dependent: :destroy

  validates :sub_total, :taxes, :total, presence: true
  validates :approved, inclusion: { in: [true, false] }
  validates :status, inclusion: { in: %w[creado procesado enviado entregado] }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :sub_total, :taxes, :total, :rate, :balance, numericality: { greater_than: 0 }
  validates :total, numericality: { greater_than_or_equal_to: :sub_total }
  validates :total, numericality: { greater_than_or_equal_to: :balance }

  def change_status!(new_status)
    initial_status = status
    return true if initial_status == new_status

    result = update(status: new_status)
    order_histories.create(from: initial_status, to: new_status, user: Current.user)
    result
  end

  def next_status
    index = Setting.order_statuses.find_index(status)
    return status unless index < Setting.order_statuses.size - 1

    Setting.order_statuses[index + 1]
  end

  def next_status!
    initial_status = status
    return if initial_status == next_status

    update(status: next_status)
    order_histories.create(from: initial_status, to: status, user: Current.user)
  end

  def previous_status
    index = Setting.order_statuses.find_index(status)
    return status unless index.positive?

    Setting.order_statuses[index - 1]
  end

  def previous_status!
    initial_status = status
    return if initial_status == previous_status

    update(status: previous_status)
    order_histories.create(from: initial_status, to: status, user: Current.user)
  end

  def self.new_with_initials(order_params)
    order = Current.orders.new(order_params.except(:order_details))

    order.user = Current.user
    order.corporation = Current.corporation
    order.client = Client.mine.find(order_params[:client_id])
    order.currency = Currency.find(order_params[:currency_id])
    order.payment_condition = Current.payment_conditions.find(order_params[:payment_condition_id])

    order.balance = order_params[:total]
    order.rate = order.currency.rate
    order.status = 'creado'

    order
  end

  def self.update_with_references(order_params, id)
    order = Current.orders.find(id)

    order.update(client: Client.mine.find(order_params[:client_id]))
    order.update(currency: Currency.find(order_params[:currency_id]))
    order.update(payment_condition: Current.payment_conditions.find(order_params[:payment_condition_id]))
    order.balance = order_params[:total]
    order.rate = order.currency.rate
    order
  rescue ActiveRecord::RecordNotFound
    raise ActiveRecord::RecordNotFound, 'Client or payment condition not found'
  end

  def add_details(details_params)
    details_params.each do |order_detail|
      new_detail = order_details.new(order_detail)
      new_detail.item = Item.mine.find(order_detail[:item_id])
      new_detail.currency = Currency.find(order_detail[:currency_id])
      new_detail.unit_price = new_detail.item.price
      new_detail.total_price = new_detail.qty * new_detail.unit_price
      new_detail.save!
    end
  rescue ActiveRecord::RecordNotFound
    not_found('Item or currency')
    raise
  end

  def with_relations
    order = attributes
    order['client'] = client.attributes
    order['user'] = user.attributes
    order['currency'] = currency.attributes
    order['payment_condition'] = payment_condition.attributes

    order['order_details'] = order_details.map do |order_detail|
      detail = order_detail.attributes
      detail['item'] = order_detail.item.attributes
      detail
    end
    order
  end
end
