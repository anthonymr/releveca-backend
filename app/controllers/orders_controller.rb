class OrdersController < ApplicationController
  before_action :check_corporation
  before_action :check_user

  rescue_from(ActiveRecord::RecordNotFound) { |e| not_found(e.message) }

  def index
    orders = Current.user.orders.includes(:client, :user, :currency, :payment_condition, order_details: :item)
    
    filtered_orders = []

    orders.each do |order|
      if order.client.name.downcase.include?(params[:filter].downcase) || order.client.code.downcase.include?(params[:filter].downcase)
        filtered_orders << order.with_relations
      end
    end

    filtered_orders = PaginationService.call(filtered_orders, params[:page], params[:count])
    ok(filtered_orders, 'Items retrieved successfully')
  end

  def show
    order = Current.user.orders.find(params[:id])
    ok(order.with_relations, 'Order retrieved successfully')
  end

  def pending
    ok(Order.pending_json, 'Pending orders retrieved successfully')
  end

  def with_debt
    ok(Order.debt_json, 'Orders with debt retrieved successfully')
  end

  def create
    new_order = Order.new(order_params.except(:order_details))
    new_order.add_details(order_params[:order_details])

    if new_order.persisted?
      ok(new_order, 'Order created successfully')
    else
      unprocessable_entity(order)
    end
  end

  def update
    if order.update(order_params)
      ok(order, 'Order updated successfully')
    else
      unprocessable_entity(order)
    end
  end

  def change_status
    if order.change_status!(params[:status])
      ok(order, 'Order status changed successfully')
    else
      unprocessable_entity(order)
    end
  end

  def change_status_next
    order.next_status!
    ok(order, 'Order status changed successfully to next')
  end

  def change_status_previous
    order.previous_status!
    ok(order, 'Order status changed successfully to previous')
  end

  def change_approval
    if order.update(approved: true)
      order.histories.create(from: 'no aprobado', to: 'aprobado', user: Current.user)
      ok(order, 'Order approval changed successfully')
    else
      unprocessable_entity(order)
    end
  end

  def history
    ok(order.order_histories, 'Order history retrieved successfully')
  end

  private

  def order
    @order ||= Order.current.find(params[:id])
  end

  def order_params
    params.permit(
      :client_id,
      :currency_id,
      :payment_condition_id,
      :sub_total,
      :taxes,
      :total,
      :status,
      :order,
      order_details: %i[
        qty
        item_id
        currency_id
        unit_price
        total_price
      ]
    )
  end
end
