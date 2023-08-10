class CurrenciesController < ApplicationController
  before_action :check_corporation
  before_action :check_user

  rescue_from(ActiveRecord::RecordNotFound) { |e| not_found(e.message) }

  def index
    ok(Currency.all, 'Currencies retrieved successfully')
  end

  def show
    ok(currency, 'Currency retrieved successfully')
  end

  def create
    new_currency = Currency.new(currency_params)

    if new_currency.save
      ok(new_currency, 'Currency created')
    else
      bad_request(new_currency.errors)
    end
  end

  def update
    if currency.update(currency_params)
      ok(currency, 'Currency updated')
    else
      bad_request(currency.errors)
    end
  end

  def destroy
    ok(currency, 'Currency deleted') if currency.destroy
  end

  private

  def currency_params
    params.permit(:code, :description, :rate, :index)
  end

  def currency
    @currency ||= Currency.find(params[:id])
  end
end
