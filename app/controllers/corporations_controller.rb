class CorporationsController < ApplicationController
  def index
    ok(Corporation.all_enabled, 'Corporations retrieved successfully')
  end

  def show
    corporation = Corporation.find(params[:id])
    ok(corporation, 'Corporation retrieved successfully')
  rescue ActiveRecord::RecordNotFound
    not_found('Corporation')
  end

  def current
    return not_found('Corporation') unless Setting.corporation

    ok(Setting.corporation, 'Corporation retrieved successfully')
  end

  def select
    corporation = Corporation.find(params[:id])
    return forbidden unless Current.user.corporations.include?(corporation)

    Setting.corporation = corporation
    ok(Setting.corporation, 'Corporation setted successfully')
  rescue ActiveRecord::RecordNotFound
    not_found('Corporation')
  end

  def create
    corporation = Corporation.new(corporation_params)
    return unprocessable_entity(corporation) unless corporation.save

    ok(corporation, 'Corporation created successfully')
  end

  def update
    return not_found('Corporation') unless Setting.corporation
    return unprocessable_entity(Setting.corporation) unless Setting.corporation.update(corporation_params)

    ok(Setting.corporation, 'Corporation updated successfully')
  end

  def change_status
    corporation = Corporation.find(params[:id])
    if corporation.update(status: params[:status])
      accepted(corporation,
               'Corporation statud changed')
    else
      unprocessable_entity(corporation)
    end
  rescue ActiveRecord::RecordNotFound
    not_found('Corporation')
  end

  private

  def corporation_params
    params.permit(:name, :rif, :address, :phone, :email, :website)
  end
end
