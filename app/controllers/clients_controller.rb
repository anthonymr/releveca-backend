class ClientsController < ApplicationController
  before_action :check_corporation
  before_action :check_user

  def index
    filtered_clients = Client.mine_filtered(params[:filter])
    paginated_clients = PaginationService.call(filtered_clients, params[:page], params[:count])
    ok(paginated_clients, 'Clients retrieved successfully')
  end

  def show
    ok(client, 'Client retrieved successfully')
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
  rescue ActiveRecord::RecordNotFound
    not_found('Client')
  end

  def client_params
    params.permit(:code, :client_type, :name, :phone, :notes, :address, :rif, :taxpayer, :nit, :email, :index,
                  :country_id)
  end

  def client_patch_params
    params.permit(:name, :phone, :notes, :address, :taxpayer, :email)
  end
end
