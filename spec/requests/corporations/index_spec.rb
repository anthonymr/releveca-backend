require 'rails_helper'

RSpec.describe('Corporations', type: :request) do
  describe('GET /api/v1/corporations') do
    let!(:token) { simulate_login }
    let!(:route) { corporations_path }
    let!(:corporation1) { FactoryBot.create(:corporation) }
    let!(:corporation2) { FactoryBot.create(:corporation) }
    let!(:corporation3) { FactoryBot.create(:corporation) }

    before do
      @user.corporations << corporation1
      @user.corporations << corporation2
    end

    context('when user is logged in') do
      it('should return only my corporations') do
        get(route, as: :json, headers: { Authorization: token })
        expect(response).to have_http_status(:ok)
        expect(json['payload'].length).to eq(2)
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
