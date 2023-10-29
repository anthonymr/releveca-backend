class Order < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :currency
  belongs_to :payment_condition
  belongs_to :corporation
  has_many :order_details, dependent: :destroy
  has_many :details, class_name: 'OrderDetail', dependent: :destroy
  has_many :order_histories, dependent: :destroy
  has_many :histories, class_name: 'OrderHistory', dependent: :destroy
  has_many :payments, dependent: :restrict_with_error

  validates :sub_total, :taxes, :total, presence: true
  validates :status, inclusion: { in: %w[creado procesado enviado entregado] }
  validates :balance, :taxes, numericality: { greater_than_or_equal_to: 0 }
  validates :sub_total, :total, :rate, :balance, numericality: { greater_than: 0 }
  validates :total, numericality: { greater_than_or_equal_to: :sub_total }
  validates :total, numericality: { greater_than_or_equal_to: :balance }

  after_initialize do |new_order|
    if new_order.new_record?
      new_order.approved = false
      new_order.status = 'creado'
      new_order.user = Current.user
      new_order.corporation = Current.corporation
      new_order.balance = new_order.total
      new_order.rate = new_order.currency&.rate
    end
  end

  def add_payment(payment_params)
    # the payment cant be greater than the balance
    # rest the payment to the balance after register the payment
  end

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

  def previous_status
    index = Setting.order_statuses.find_index(status)
    return status unless index.positive?

    Setting.order_statuses[index - 1]
  end

  def next_status!
    change_status!(next_status)
  end

  def previous_status!
    change_status!(previous_status)
  end

  def add_details(details_params)
    details_params.each do |params|
      new_detail = order_details.new(params)
      new_detail.save!
    end
  rescue ActiveRecord::RecordNotFound
    not_found('Item or currency')
    raise
  end

  def with_relations
    children = [:client, :user, :currency, :payment_condition, { histories: {include: :user} }, { order_details: { include: :item } }]
    ActiveSupport::JSON.decode(to_json(include: children))
  end

  def self.current_json
    current.map(&:with_relations)
  end

  def self.debt_json
    current_json.select { |order| order['balance'].positive? }
  end

  def self.pending_json
    current_json.select { |order| order['approved'] == false }
  end
end
