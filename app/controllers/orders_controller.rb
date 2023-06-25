class OrdersController < ApplicationController
  before_action :check_corporation
  before_action :check_user

  def index
    ok(Current.orders, 'Orders retrieved successfully')
  end

  def show
    ok(Current.orders.find(params[:id]), 'Order retrieved successfully')
  end

  def create
    order = Order.new_with_initials(order_params)

    if order.save
      ok(order, 'Order created successfully')
    else
      unprocessable_entity(order.errors)
    end
  end

  def update
    order = Order.update_with_references(order_params, params[:id])

    if order.update(order_params)
      ok(order, 'Order updated successfully')
    else
      unprocessable_entity(order.errors)
    end
  end

  def change_status
    order = Current.orders.find(params[:id])

    if order.update(status: params[:status])
      ok(order, 'Order status changed successfully')
    else
      unprocessable_entity(order.errors)
    end
  end

  def change_approval
    order = Current.orders.find(params[:id])

    if order.update(approved: params[:approved])
      ok(order, 'Order approval changed successfully')
    else
      unprocessable_entity(order.errors)
    end
  end

  private

  def order_params
    params.permit(
      :client_id,
      :currency_id,
      :payment_condition_id,
      :sub_total,
      :taxes,
      :total,
      :status
    )
  end
end
