class ItemsController < ApplicationController
  before_action :check_corporation

  def index
    filtered_items = Item.mine_filtered(params[:filter])
    paginated_items = PaginationService.call(filtered_items, params[:page], params[:count])
    ok(paginated_items, 'Items retrieved successfully')
  end

  def show
    ok(item, 'Item retrieved successfully')
  end

  def create
    item = Item.mine.new(item_params)
    item.save ? ok(item, 'Item created successfully') : bad_request(item.errors)
  end

  def update
    item.update(item_params) ? ok(item, 'Item updated successfully') : bad_request(item.errors)
  end

  def change_status
    item.update(status: params[:status]) ? ok(item, 'Item status changed successfully') : bad_request(item.errors)
  end

  def change_stock
    item.update(stock: params[:stock]) ? ok(item, 'Item stock changed successfully') : bad_request(item.errors)
  end

  private

  def item
    @item ||= Item.mine.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def item_params
    params.permit(:code, :name, :model, :stock, :unit, :price, :index)
  end
end
