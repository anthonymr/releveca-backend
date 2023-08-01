class CurrenciesController < ApplicationController
  def index
    ok(Currency.all, 'Currencies retrieved successfully')
  end

  def show
    ok(currency, 'Currency retrieved successfully')
  end

  def create
    new_currency = Currency.new(currency_params)
    new_currency.save ? ok(new_currency, 'Currency created') : bad_request(new_currency.errors)
  end

  def update
    currency.update(currency_params) ? ok(currency, 'Currency updated') : bad_request(currency.errors)
  end

  def destroy
    to_delete = Currency.find(params[:id])
    ok(to_delete, 'Currency deleted') if to_delete.destroy
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  private

  def currency_params
    params.permit(:code, :description, :rate, :index)
  end

  def currency
    @currency ||= Currency.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end
end
