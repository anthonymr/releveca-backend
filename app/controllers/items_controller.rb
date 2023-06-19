class ItemsController < ApplicationController
  def index
    return forbidden('First select a corporation') unless Setting.corporation

    ok(Setting.corporation.items, 'Items retrieved successfully')
  end

  def show
    return forbidden('First select a corporation') unless Setting.corporation

    ok(Setting.corporation.items.find(params[:id]), 'Item retrieved successfully')
  rescue ActiveRecord::RecordNotFound
    not_found('Item not found')
  end

  def create
    return forbidden('First select a corporation') unless Setting.corporation

    item = Setting.corporation.items.new(item_params)
    item.save ? ok(item, 'Item created successfully') : bad_request(item.errors)
  end

  private

  def item_params
    params.permit(:code, :name, :model, :stock, :unit, :price, :index)
  end
end
