class CountriesController < ApplicationController
  def index
    ok(Country.all, 'Countries retrieved successfully')
  end

  def create
    country = Country.new(country_params)
    return ok(country, 'Country created') if country.save

    unprocessable_entity(country)
  end

  def destroy
    country = Country.find(params[:id])
    ok(country, 'Country deleted') if country.destroy
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  private

  def country_params
    params.permit(:name)
  end
end
