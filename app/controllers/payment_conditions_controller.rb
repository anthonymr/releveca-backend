class PaymentConditionsController < ApplicationController
  before_action :check_user
  before_action :check_corporation

  rescue_from(ActiveRecord::RecordNotFound) { |e| not_found(e.message) }

  def index
    ok(PaymentCondition.mine, 'payment_conditions retrieved successfully')
  end

  def show
    ok(payment_condition, 'payment_condition retrieved successfully')
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
    if payment_condition.update(payment_condition_params)
      ok(payment_condition, 'payment_condition updated successfully')
    else
      unauthorized('payment_condition not valid')
    end
  end

  def destroy
    if payment_condition.destroy
      ok(payment_condition, 'payment_condition destroyed successfully')
    else
      unauthorized('payment_condition not valid')
    end
  end

  private

  def payment_condition
    @payment_condition ||= PaymentCondition.mine.find(params[:id])
  end

  def payment_condition_params
    params.require(:payment_condition).permit(:code, :description, :days, :index)
  end
end
