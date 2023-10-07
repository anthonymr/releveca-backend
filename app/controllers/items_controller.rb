class ItemsController < ApplicationController
  before_action :check_user
  before_action :check_corporation

  rescue_from(ActiveRecord::RecordNotFound) { |e| not_found(e.message) }
  rescue_from(ActiveRecord::RecordNotUnique) { |e| not_unique }

  def index
    filtered_items = Item.mine.search(params[:filter])
    paginated_items = PaginationService.call(filtered_items, params[:page], params[:count])
    ok(paginated_items, 'Items retrieved successfully')
  end

  def show
    ok(item, 'Item retrieved successfully')
  end

  def create
    new_item = Item.mine.new(item_params)

    if new_item.save
      ok(new_item, 'Item created successfully')
    else
      bad_request(new_item.errors)
    end
  end

  def update
    if item.update(item_params)
      ok(item, 'Item updated successfully')
    else
      bad_request(item.errors)
    end
  end

  def change_status
    if item.update(status: params[:status])
      ok(item, 'Item status changed successfully')
    else
      bad_request(item.errors)
    end
  end

  def change_stock
    if item.update(stock: params[:stock])
      ok(item, 'Item stock changed successfully')
    else
      bad_request(item.errors)
    end
  end

  private

  def item
    @item ||= Item.mine.find(params[:id])
  end

  def item_params
    params.permit(:code, :name, :model, :stock, :unit, :price, :index)
  end
end
