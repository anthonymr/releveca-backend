class CountriesController < ApplicationController
  def index
    ok(Country.all, 'Countries retrieved successfully')
  end

  def create
    country = Country.new(country_params)
    if country.save
      ok(country, 'Country created')
    else
      unprocessable_entity(country)
    end
  end

  def destroy
    country = Country.find(params[:id])
    if country.destroy
      ok(country, 'Country deleted')
    else
      unprocessable_entity(country)
    end
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  private

  def country_params
    params.permit(:name)
  end
end
