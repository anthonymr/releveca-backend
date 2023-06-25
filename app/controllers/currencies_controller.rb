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
    # Check if currency is in use before destroy when implemented
    to_delete = Currency.find(params[:id])
    return ok(to_delete, 'Currency deleted') if to_delete.destroy

    unprocessable_entity(to_delete)
  end

  private

  def currency_params
    params.permit(:code, :description, :rate, :index)
  end

  def currency
    @currency || Currency.find(params[:id])
  end
end
