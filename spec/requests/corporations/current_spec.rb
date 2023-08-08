require 'rails_helper'

RSpec.describe('Corporations API', type: :request) do
  describe('GET /corporations/current') do
    let!(:token) { simulate_login }
    let!(:route) { current_corporation_path }

    context('with valid token and parameters') do
      let!(:corporation) { select_corporation(token) }
      it('returns current corporation') do
        get(route, headers: { Authorization: token })
        expect(response).to(have_http_status(:success))
        expect(json['payload']['id']).to(eq(corporation.id))
      end
    end

    context('with valid token but not current corporation selected') do
      it('returns unauthorized code') do
        get(route, headers: { Authorization: token })
        expect(response).to(have_http_status(:unauthorized))
      end
    end

    context('with no token and valid parameters') do
      it('returns unauthorized code') do
        get(route)
        expect(response).to(have_http_status(:unauthorized))
      end
    end

    context('with invalid token and valid parameters') do
      it('returns unauthorized code') do
        get(route, headers: { Authorization: 'invalid token' })
        expect(response).to(have_http_status(:unauthorized))
      end
    end
  end
end
