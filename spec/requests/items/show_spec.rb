require 'rails_helper'

RSpec.describe('GET /items/:id', type: :request) do
  describe('GET /items/:id') do
    let!(:token) { simulate_login }
    let!(:corporation) { select_corporation(token) }
    let!(:item) { FactoryBot.create(:item, corporation:) }
    let!(:not_my_item) { FactoryBot.create(:item) }
    let!(:route) { item_path(item) }

    context('when user is logged in, item exists and item is mine') do
      before do
        get(route, headers: { Authorization: token })
      end

      it('returns status code 200') do
        expect(response).to(have_http_status(200))
      end

      it('returns the correct item') do
        expect(json['payload']['id']).to eq(item.id)
      end

      it('returns the item only if mine') do
        expect(json['payload']['corporation_id']).to eq(corporation.id)
      end

      it('has all its attributes') do
        expect(json['payload']).to include('code', 'name', 'model', 'stock',
                                           'unit', 'price', 'index',
                                           'corporation_id')
      end
    end

    context('when user is logged in, item exists and item is not mine') do
      it('returns not_found status code') do
        get(item_path(not_my_item), headers: { Authorization: token })
        expect(response).to have_http_status(:not_found)
      end
    end

    context('when user is logged in and item does not exist') do
      it('returns not_found status code') do
        get(item_path(0), headers: { Authorization: token })
        expect(response).to have_http_status(:not_found)
      end
    end

    context('when user is not logged in') do
      it('returns unauthorized status code') do
        get(route)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('with invalid token') do
      it('returns unauthorized status code') do
        get(route, headers: { Authorization: 'invalid token' })
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
