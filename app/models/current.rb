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
    corporation&.orders&.where(user:)
  end
end
