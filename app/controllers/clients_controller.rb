class ClientsController < ApplicationController
  before_action :check_corporation
  before_action :check_user

  rescue_from(ActiveRecord::RecordNotFound) { |e| not_found(e.message) }

  def index
      filtered_clients = Client.mine.search(params[:filter])
      if params[:page] != nil && params[:count] != nil
        paginated_clients = PaginationService.call(filtered_clients, params[:page], params[:count])
        ok(paginated_clients, 'Clients retrieved successfully')
      else
        ok({ items: filtered_clients }, 'Clients retrieved successfully')
      end
  end

  def show
    found_client = ActiveSupport::JSON.decode(client.to_json(include: :country))
    ok(found_client, 'Client retrieved successfully')
  end

  def create
    new_client = Client.new(client_params)
    if new_client.save
      ok(new_client, 'Client created')
    else
      bad_request(new_client.errors)
    end
  end

  def update
    return unauthorized("Can't update approved client") if client.approved?

    if client.update(client_params)
      ok(client, 'Client updated')
    else
      bad_request(client.errors)
    end
  end

  def patch
    if client.update(client_patch_params)
      ok(client, 'Client patched')
    else
      bad_request(client.errors)
    end
  end

  def change_status
    if client.update(status: params[:status])
      ok(client, 'Client status changed')
    else
      bad_request(client.errors)
    end
  end

  def change_approval
    if client.update(approval: params[:approval])
      ok(client, 'Client approval changed')
    else
      bad_request(client.errors)
    end
  end

  private

  def client
    @client ||= Client.mine.find(params[:id])
  end

  def client_params
    params.permit(:code, :client_type, :name, :phone, :notes, :address, :rif, :taxpayer, :nit, :email, :index,
                  :country_id)
  end

  def client_patch_params
    params.permit(:name, :phone, :notes, :address, :taxpayer, :email, :client_type)
  end
end
