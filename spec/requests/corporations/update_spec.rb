require 'rails_helper'

RSpec.describe('Corporations', type: :request) do
  describe('PUT /api/v1/corporations') do
    let!(:token) { simulate_login }
    let!(:route) { update_corporation_path }
    let!(:corporation) { select_corporation(token) }

    context('with valid token and parameters') do
      it('returns success code') do
        put(route, params: { name: 'New name' }, headers: { Authorization: token })
        expect(response).to(have_http_status(:success))
      end
    end

    context('with valid token and invalid parameters') do
      it('returns unprocessable_entity code') do
        put(route, params: { name: '' }, headers: { Authorization: token })
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end

    context('with no token and valid parameters') do
      it('returns unauthorized code') do
        put(route, params: { name: 'New name' })
        expect(response).to(have_http_status(:unauthorized))
      end
    end

    context('with invalid token and valid parameters') do
      it('returns unauthorized code') do
        put(route, params: { name: 'New name' }, headers: { Authorization: 'invalid token' })
        expect(response).to(have_http_status(:unauthorized))
      end
    end
  end
end
