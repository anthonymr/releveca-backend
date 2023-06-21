class ClientsController < ApplicationController
  before_action :check_corporation
  before_action :check_user

  def index
    ok(Current.clients, 'Clients retrieved successfully')
  end

  def show
    ok(client, 'Client retrieved successfully')
  end

  def create
    new_client = Client.new(client_params)
    new_client.status = 'enabled'
    new_client.approval = false
    new_client.user_id = Current.user.id
    new_client.corporation = Current.corporation
    new_client.save ? ok(new_client, 'Client created') : bad_request(new_client.errors)
  end

  def update
    return forbidden('Not allowed') if client.approved?

    client.update(client_params) ? ok(client, 'Client updated') : bad_request(client.errors)
  end

  def patch
    return forbidden('Not allowed') unless client.approved?

    client.update(client_patch_params) ? ok(client, 'Client patched') : bad_request(client.errors)
  end

  def change_status
    client.update(status: params[:status]) ? ok(client, 'Client status changed') : bad_request(client.errors)
  end

  def change_approval
    client.update(approval: params[:approval]) ? ok(client, 'Client approval changed') : bad_request(client.errors)
  end

  private

  def client
    Current.clients.find(params[:id])
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
