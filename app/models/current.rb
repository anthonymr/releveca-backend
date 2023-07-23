class Current < ActiveSupport::CurrentAttributes
  include ::Paginable

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

  def items_page(page, count = 12)
    pp items
    pp page
    pp count
    paginate(items, page, count)
  end

  def items_enabled
    corporation&.items&.where(status: 'enabled')
  end

  def clients
    corporation&.clients&.where(user:)
  end

  def clients_page(page, count)
    paginate(clients, page, count)
  end

  def payment_conditions
    corporation&.payment_conditions
  end

  def orders
    corporation&.orders&.where(user:)
  end
end
