class PaymentConditionsController < ApplicationController
  before_action :check_corporation

  def index
    ok(Current.payment_conditions, 'payment_conditions retrieved successfully')
  end

  def show
    payment_condition = Current.payment_conditions.find(params[:id])
    return unauthorized('payment_condition not found') unless payment_condition.allowed?

    ok(payment_condition, 'payment_condition retrieved successfully')
  end

  def create
    payment_condition = PaymentCondition.new(payment_condition_params)
    payment_condition.corporation = Current.corporation
    return unauthorized('payment_condition not valid') unless payment_condition.save

    ok(payment_condition, 'payment_condition created successfully')
  end

  def update
    payment_condition = Current.payment_conditions.find(params[:id])
    return unauthorized('payment_condition not found') unless payment_condition.allowed?
    return unauthorized('payment_condition not valid') unless payment_condition.update(payment_condition_params)

    ok(payment_condition, 'payment_condition updated successfully')
  end

  def destroy
    payment_condition = Current.payment_conditions.find(params[:id])
    return unauthorized('payment_condition not found') unless payment_condition.allowed?

    payment_condition.destroy
    ok(payment_condition, 'payment_condition destroyed successfully')
  end

  private

  def payment_condition_params
    params.require(:payment_condition).permit(:code, :description, :days, :index)
  end
end
