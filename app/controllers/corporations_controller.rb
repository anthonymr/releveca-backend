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
    return forbidden('No corporation selected') unless Setting.corporation
    return unprocessable_entity(Setting.corporation) unless Setting.corporation.update(corporation_params)

    ok(Setting.corporation, 'Corporation updated successfully')
  end

  def change_status
    return unprocessable_entity(corporation) unless corporation.update(status: params[:status])

    accepted(corporation, 'Corporation statud changed')
  end

  def current
    return forbidden('No corporation selected') unless Setting.corporation

    ok(Setting.corporation, 'Corporation retrieved successfully')
  end

  def select
    return forbidden unless Current.user.corporations.include?(corporation)

    Setting.corporation = corporation
    ok(Setting.corporation, 'Corporation setted successfully')
  end

  def items
    return forbidden('No corporation selected') unless Setting.corporation

    ok(Setting.corporation.items.where(status: 'enabled'), 'Items retrieved successfully')
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
