class CurrenciesController < ApplicationController
  def index
    ok(Currency.all, 'Currencies retrieved successfully')
  end

  def show
    ok(currency, 'Currency retrieved successfully')
  rescue ActiveRecord::RecordNotFound
    not_found('Currency')
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
  rescue ActiveRecord::RecordNotFound
    not_found('Currency')
  end

  def destroy
    ok(currency, 'Currency deleted') if currency.destroy
  rescue ActiveRecord::RecordNotFound
    not_found('Currency')
  end

  private

  def currency_params
    params.permit(:code, :description, :rate, :index)
  end

  def currency
    @currency ||= Currency.find(params[:id])
  end
end
