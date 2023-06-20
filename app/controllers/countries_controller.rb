class CountriesController < ApplicationController
  def index
    ok(Country.all)
  end

  def create
    country = Country.new(country_params)
    return ok(country, 'Country created') if country.save

    unprocessable_entity(country.errors)
  end

  def destroy
    country = Country.find(params[:id])
    return ok(country, 'Country deleted') if country.destroy

    unprocessable_entity(country.errors)
  end

  private

  def country_params
    params.permit(:name)
  end
end
