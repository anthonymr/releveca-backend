class PaymentConditionsController < ApplicationController
  before_action :check_corporation

  def index
    ok(Current.payment_conditions, 'payment_conditions retrieved successfully')
  end

  def show
    if payment_condition.mine?
      ok(payment_condition, 'payment_condition retrieved successfully')
    else
      not_found('payment_condition')
    end
  rescue ActiveRecord::RecordNotFound
    not_found('payment_condition')
  end

  def create
    new_payment_condition = PaymentCondition.new(payment_condition_params)
    new_payment_condition.corporation = Current.corporation

    if new_payment_condition.save
      ok(payment_condition, 'payment_condition created successfully')
    else
      unauthorized('payment_condition not valid')
    end
  end

  def update
    return unauthorized('payment_condition not found') unless payment_condition.mine?

    if payment_condition.update(payment_condition_params)
      ok(payment_condition, 'payment_condition updated successfully')
    else
      unauthorized('payment_condition not valid') 
    end
  rescue ActiveRecord::RecordNotFound
    not_found('payment_condition')
  end

  def destroy
    return unauthorized('payment_condition not found') unless payment_condition.mine?

    payment_condition.destroy
    ok(payment_condition, 'payment_condition destroyed successfully')
  rescue ActiveRecord::RecordNotFound
    not_found('payment_condition')
  end

  private

  def payment_condition
    @payment_condition ||= Current.payment_conditions.find(params[:id])
  end

  def payment_condition_params
    params.require(:payment_condition).permit(:code, :description, :days, :index)
  end
end
