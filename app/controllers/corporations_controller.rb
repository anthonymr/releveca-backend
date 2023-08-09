class CorporationsController < ApplicationController
  def index
    ok(Current.corporations, 'Corporations retrieved successfully')
  end

  def show
    ok(corporation.with_childs, 'Corporation retrieved successfully')
  rescue ActiveRecord::RecordNotFound
    not_found('Corporation')
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

    if Current.corporation.update(corporation_params)
      ok(Current.corporation, 'Corporation updated successfully')
    else
      unprocessable_entity(Current.corporation)
    end
  end

  def change_status
    if corporation.update(status: params[:status])
      ok(corporation, 'Corporation statud changed')
    else
      unprocessable_entity(corporation)
    end
  rescue ActiveRecord::RecordNotFound
    not_found('Corporation')
  end

  def current
    return unauthorized('No corporation selected') unless Current.corporation

    ok(Current.corporation, 'Corporation retrieved successfully')
  end

  def select
    return unauthorized unless Current.corporations.include?(corporation)

    Current.corporation = corporation
    ok(Current.corporation.with_childs, 'Corporation setted successfully')
  rescue ActiveRecord::RecordNotFound
    not_found('Corporation')
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
  end
end
