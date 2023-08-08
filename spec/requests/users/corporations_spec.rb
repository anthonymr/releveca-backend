require 'rails_helper'

RSpec.describe('Users', type: :request) do
  describe('GET /api/v1/users/corporations') do
    let!(:token) { simulate_login }
    let!(:route) { user_corporations_path }

    context('when user is logged in and corporation selected') do
      let!(:corporation) { select_corporation(token) }
      it('should return the current corporations') do
        get(route, as: :json, headers: { Authorization: token })
        expect(response).to have_http_status(:ok)
        expect(json['payload'].first['name']).to eq(corporation.name)
      end
    end

    context('when user is not logged in') do
      it('should return unauthorized error') do
        get(route, as: :json)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('with invalid loggin') do
      it('should return unauthorized error') do
        get(route, as: :json, headers: { Authorization: 'invalid token' })
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('when user is logged in but not selected a corporation') do
      it('should return unauthorized error') do
        get(route, as: :json, headers: { Authorization: token })
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
