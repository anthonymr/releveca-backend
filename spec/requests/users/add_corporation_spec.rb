require 'rails_helper'

RSpec.describe('Users', type: :request) do
  describe('POST /api/v1/users/corporations') do
    let!(:token) { simulate_login }
    let!(:route) { user_add_corporation_path }
    let!(:new_corporation) { FactoryBot.create(:corporation) }

    context('when user is logged in and corporation selected') do
      let!(:corporation) { select_corporation(token) }

      it('should return the current corporations') do
        post(route, as: :json, headers: { Authorization: token }, params: { id: new_corporation.id })
        expect(response).to have_http_status(:ok)
        expect(json['payload']['name']).to eq(new_corporation.name)

        expect(@user.corporations.include?(new_corporation)).to eq(true)
      end
    end

    context('when user is not logged in') do
      it('should return unauthorized error') do
        post(route, as: :json, params: { id: new_corporation.id })
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('with invalid token') do
      it('should return unauthorized error') do
        post(route, as: :json, headers: { Authorization: 'Invalid token'}, params: { id: new_corporation.id })
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
