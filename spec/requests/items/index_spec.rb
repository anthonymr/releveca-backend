require 'rails_helper'

RSpec.describe('Items', type: :request) do
  describe('GET /items') do
    let!(:token) { simulate_login }
    let!(:corporation) { select_corporation(token) }
    let!(:route) { items_path }
    let!(:items) { FactoryBot.create_list(:item, 10, corporation:) }
    let!(:no_my_items) { FactoryBot.create_list(:item, 10) }

    context('with valid token') do
      it('returns all items when no pagination') do
        get(route, headers: { Authorization: token })
        expect(response).to have_http_status(200)
        expect(json['payload']['items'].size).to eq(10)
      end

      it('returns few items when pagination') do
        get(route, params: { page: 1, count: 5 }, headers: { Authorization: token })
        expect(response).to have_http_status(200)
        expect(json['payload']['items'].size).to eq(5)
        expect(json['payload']['pagination']['total_items']).to eq(10)
        expect(json['payload']['pagination']['current_page']).to eq(1)
      end
    end

    context('with invalid token') do
      it('returns unauthorized') do
        get(route, headers: { Authorization: 'invalid token' })
        expect(response).to have_http_status(401)
      end
    end

    context('with no token') do
      it('returns unauthorized') do
        get(route)
        expect(response).to have_http_status(401)
      end
    end
  end
end
