class Current < ActiveSupport::CurrentAttributes
  attribute :user

  def corporation
    user&.current_corporation
  end

  def corporation=(corporation)
    user&.update(current_corporation: corporation)
  end

  def corporations
    user&.corporations&.where(status: 'enabled')
  end

  def items
    corporation&.items
  end

  def items_enabled
    corporation&.items&.where(status: 'enabled')
  end

  def clients
    corporation&.clients&.where(user:)
  end

  def payment_conditions
    corporation&.payment_conditions
  end

  def orders
    corporation&.orders&.where(user:)
  end
end
