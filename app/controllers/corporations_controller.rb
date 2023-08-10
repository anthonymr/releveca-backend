class CorporationsController < ApplicationController
  before_action :check_user
  before_action :check_corporation, only: %i[update current items]

  rescue_from(ActiveRecord::RecordNotFound) { |e| not_found(e.message) }

  def index
    ok(Current.corporations, 'Corporations retrieved successfully')
  end

  def show
    ok(corporation.hash_with_children, 'Corporation retrieved successfully')
  end

  def create
    new_corporation = Corporation.new(corporation_params)
    if new_corporation.save
      created(new_corporation)
    else
      unprocessable_entity(new_corporation)
    end
  end

  def update
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
  end

  def current
    ok(Current.corporation, 'Corporation retrieved successfully')
  end

  def select
    return unauthorized unless corporation.mine?

    Current.corporation = corporation
    ok(Current.corporation.hash_with_children, 'Corporation setted successfully')
  end

  def items
    ok(Item.mine.enabled)
  end

  private

  def corporation_params
    params.permit(:name, :rif, :address, :phone, :email, :website, :base_currency_id, :default_currency_id)
  end

  def corporation
    @corporation ||= Corporation.find(params[:id])
  end
end
