require 'rails_helper'

RSpec.describe('Items', type: :request) do
  describe('POST /items') do
    let!(:token) { simulate_login }
    let!(:corporation) { select_corporation(token) }
    let!(:route) { items_path }
    let!(:valid_params) { FactoryBot.attributes_for(:item) }

    context('when user is logged in and params are valid') do
      before do
        post(route, params: valid_params, headers: { Authorization: token })
      end

      it('returns ok status code') do
        expect(response).to(have_http_status(:ok))
      end

      it('returns the correct item') do
        expect(json['payload']['code']).to eq(valid_params[:code])
      end

      it('creates the item') do
        expect(Item.count).to eq(1)
      end

      it('new item belongs to the corporation') do
        expect(Item.last.corporation_id).to eq(corporation.id)
      end
    end

    context('when user is logged in and no params') do
      before do
        post(route, params: {}, headers: { Authorization: token })
      end

      it('returns bad_request status code') do
        expect(response).to(have_http_status(:bad_request))
      end

      it('does not create the item') do
        expect(Item.count).to eq(0)
      end
    end

    context('when user is logged in and a missing parameter') do
      it('returns bad_request status code when no code') do
        post(route, params: valid_params.except(:code), headers: { Authorization: token })
        expect(response).to(have_http_status(:bad_request))
      end

      it('returns bad_request status code when no name') do
        post(route, params: valid_params.except(:name), headers: { Authorization: token })
        expect(response).to(have_http_status(:bad_request))
      end
    end

    context('when user is logged in and a parameters are invalid') do
      it('returns bad_request status code when code is too long') do
        post(route, params: valid_params.merge(code: 'a' * 51), headers: { Authorization: token })
        expect(response).to(have_http_status(:bad_request))
      end

      it('returns bad_request status code when name is too long') do
        post(route, params: valid_params.merge(name: 'a' * 251), headers: { Authorization: token })
        expect(response).to(have_http_status(:bad_request))
      end

      it('returns bad_request status code when model is too long') do
        post(route, params: valid_params.merge(model: 'a' * 251), headers: { Authorization: token })
        expect(response).to(have_http_status(:bad_request))
      end

      it('returns bad_request status code when unit is too long') do
        post(route, params: valid_params.merge(unit: 'a' * 51), headers: { Authorization: token })
        expect(response).to(have_http_status(:bad_request))
      end

      it('returns bad_request status code when price is negative') do
        post(route, params: valid_params.merge(price: -1), headers: { Authorization: token })
        expect(response).to(have_http_status(:bad_request))
      end

      it('returns bad_request status code when stock is negative') do
        post(route, params: valid_params.merge(stock: -1), headers: { Authorization: token })
        expect(response).to(have_http_status(:bad_request))
      end

      it('returns bad_request status code when index is negative') do
        post(route, params: valid_params.merge(index: -1), headers: { Authorization: token })
        expect(response).to(have_http_status(:bad_request))
      end
    end

    context('whith no token') do
      before do
        post(route, params: valid_params)
      end

      it('returns unauthorized status code') do
        expect(response).to(have_http_status(:unauthorized))
      end

      it('does not create the item') do
        expect(Item.count).to eq(0)
      end
    end

    context('whith invalid token') do
      before do
        post(route, params: valid_params, headers: { Authorization: 'invalid token' })
      end

      it('returns unauthorized status code') do
        expect(response).to(have_http_status(:unauthorized))
      end

      it('does not create the item') do
        expect(Item.count).to eq(0)
      end
    end
  end
end
