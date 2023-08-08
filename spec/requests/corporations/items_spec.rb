require 'rails_helper'

RSpec.describe('Corporations', type: :request) do
  describe('GET /corporations/items') do
    let!(:token) { simulate_login }
    let!(:route) { corporation_items_path }
    let!(:corporation) { select_corporation(token) }

    before do
      @item1 = FactoryBot.create(:item, corporation:)
      @item2 = FactoryBot.create(:item, corporation:)
      @item3 = FactoryBot.create(:item)
    end

    context('with valid token and parameters') do
      it('returns only current corporation items') do
        get(route, headers: { Authorization: token })
        expect(response).to(have_http_status(:success))
        expect(json['payload'].count).to(eq(2))
      end
    end

    context('with no token') do
      it('returns unauthorized code') do
        get(route)
        expect(response).to(have_http_status(:unauthorized))
      end
    end

    context('with invalid token') do
      it('returns unauthorized code') do
        get(route, headers: { Authorization: 'Invalid token' })
        expect(response).to(have_http_status(:unauthorized))
      end
    end
  end
end
