class CorporationsController < ApplicationController
  def index
    ok(Corporation.all_enabled, 'Corporations retrieved successfully')
  end

  def show
    ok(corporation, 'Corporation retrieved successfully')
  end

  def create
    corporation = Corporation.new(corporation_params)
    return unprocessable_entity(corporation) unless corporation.save

    ok(corporation, 'Corporation created successfully')
  end

  def update
    return forbidden('No corporation selected') unless Current.corporation
    return unprocessable_entity(Current.corporation) unless Current.corporation.update(corporation_params)

    ok(Current.corporation, 'Corporation updated successfully')
  end

  def change_status
    return unprocessable_entity(corporation) unless corporation.update(status: params[:status])

    accepted(corporation, 'Corporation statud changed')
  end

  def current
    pp '#' * 100
    pp Current.corporation
    pp '#' * 100

    return forbidden('No corporation selected') unless Current.corporation

    ok(Current.corporation, 'Corporation retrieved successfully')
  end

  def select
    return forbidden unless Current.corporations.include?(corporation)

    Current.corporation = corporation
    ok(Current.corporation, 'Corporation setted successfully')
  end

  def items
    return forbidden('No corporation selected') unless Current.corporation

    ok(Current.items_enabled)
  end

  private

  def corporation_params
    params.permit(:name, :rif, :address, :phone, :email, :website)
  end

  def corporation
    Corporation.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    not_found('Corporation')
  end
end
