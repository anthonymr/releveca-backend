require 'rails_helper'

RSpec.describe('Users', type: :request) do
  describe('PATCH /api/v1/users/:id/status') do
    let!(:token) { simulate_login }
    let!(:user) { FactoryBot.create(:user) }
    let!(:route) { "/api/v1/users/#{user.id}/status" }

    context('when user is logged in') do
      it('should change user status correctly') do
        patch(route, as: :json, headers: { Authorization: token }, params: { status: 'disabled' })
        expect(response).to have_http_status(:ok)
        expect(json['payload']['status']).to eq('disabled')

        patch(route, as: :json, headers: { Authorization: token }, params: { status: 'enabled' })
        expect(response).to have_http_status(:ok)
        expect(json['payload']['status']).to eq('enabled')
      end
    end

    context('when user is not logged in') do
      it('should return unauthorized code') do
        patch(route, as: :json, params: { status: 'disabled' })
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('when token is invalid') do
      it('should return unauthorized code') do
        patch(route, as: :json, headers: { Authorization: 'Invalid token' }, params: { status: 'disabled' })
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
