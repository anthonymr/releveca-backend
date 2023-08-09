class Current < ActiveSupport::CurrentAttributes
  attribute :user

  def corporation
    user.current_corporation
  end

  def corporation=(corporation)
    user&.update(current_corporation: corporation)
  end

  def corporations
    user&.corporations&.where(status: 'enabled')
  end

  def payment_conditions
    corporation&.payment_conditions
  end

  def orders
    orders = corporation&.orders&.where(user:)&.includes(:client, :currency, :payment_condition, :order_details)

    orders.map(&:with_relations)
  end

  def orders_with_debt
    orders = corporation&.orders&.where(user:)&.includes(:client, :currency, :payment_condition, :order_details)

    orders.map(&:with_relations).select { |order| order['balance'].positive? }
  end

  def orders_pending
    orders = corporation&.orders&.where(user:)&.includes(:client, :currency, :payment_condition, :order_details)

    orders.map(&:with_relations).select { |order| order['approved'] == false }
  end
end
