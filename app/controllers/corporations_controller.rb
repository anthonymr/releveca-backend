class CorporationsController < ApplicationController
  def index
    ok(Current.corporations, 'Corporations retrieved successfully')
  end

  def show
    ok(corporation, 'Corporation retrieved successfully')
  end

  def create
    new_corporation = Corporation.create(corporation_params)
    if new_corporation.persisted?
      created(new_corporation)
    else
      unprocessable_entity(new_corporation)
    end
  end

  def update
    return unauthorized('No corporation selected') unless Current.corporation
    return unprocessable_entity(Current.corporation) unless Current.corporation.update(corporation_params)

    ok(Current.corporation, 'Corporation updated successfully')
  end

  def change_status
    return unprocessable_entity(corporation) unless corporation.update(status: params[:status])

    ok(corporation, 'Corporation statud changed')
  end

  def current
    return unauthorized('No corporation selected') unless Current.corporation

    ok(Current.corporation, 'Corporation retrieved successfully')
  end

  def select
    return unauthorized unless Current.corporations.include?(corporation)

    Current.corporation = corporation
    ok(Current.corporation.with_childs, 'Corporation setted successfully')
  end

  def items
    return unauthorized('No corporation selected') unless Current.corporation

    ok(Item.mine_enabled)
  end

  private

  def corporation_params
    params.permit(:name, :rif, :address, :phone, :email, :website, :base_currency_id, :default_currency_id)
  end

  def corporation
    @corporation ||= Corporation.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    not_found('Corporation') && return
  end
end
