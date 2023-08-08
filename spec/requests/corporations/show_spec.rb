require 'rails_helper'

RSpec.describe('Corporations', type: :request) do
  describe('GET /api/v1/corporations/:id') do
    let!(:token) { simulate_login }
    let!(:corporation) { select_corporation(token) }
    let!(:route) { corporation_path(corporation) }

    context('when user is logged in') do
      it('should return corporation') do
        get(route, as: :json, headers: { Authorization: token })
        expect(response).to have_http_status(:ok)
        expect(json['payload']['id']).to eq(corporation.id)
      end
    end

    context('when user is not logged in') do
      it('should return unauthorized error') do
        get(route, as: :json)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('with invalid token') do
      it('should return unauthorized error') do
        get(route, as: :json, headers: { Authorization: 'Invalid token' })
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
