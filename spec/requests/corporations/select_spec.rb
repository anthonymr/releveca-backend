require 'rails_helper'

RSpec.describe('Corporation', type: :request) do
  describe('POST /corporations/current') do
    let!(:token) { simulate_login }
    let!(:route) { select_corporation_path }
    let!(:corporation) { FactoryBot.create(:corporation) }

    context('with valid token and parameters') do
      it('returns current corporation') do
        @user.corporations << corporation
        post(route, params: { id: corporation.id }, headers: { Authorization: token })
        expect(response).to(have_http_status(:success))
        expect(json['payload']['id']).to(eq(corporation.id))
      end
    end

    context('with valid token but no corporation access') do
      it('returns unauthorized code') do
        post(route, params: { id: corporation.id }, headers: { Authorization: token })
        expect(response).to(have_http_status(:unauthorized))
      end
    end

    context('with no token and valid parameters') do
      it('returns unauthorized code') do
        @user.corporations << corporation
        post(route, params: { id: corporation.id })
        expect(response).to(have_http_status(:unauthorized))
      end
    end

    context('with invalid token and valid parameters') do
      it('returns unauthorized code') do
        @user.corporations << corporation
        post(route, params: { id: corporation.id }, headers: { Authorization: 'invalid token' })
        expect(response).to(have_http_status(:unauthorized))
      end
    end
  end
end
