require 'rails_helper'

RSpec.describe('User', type: :request) do
  describe('GET /api/v1/users/current') do
    let!(:token) { simulate_login }

    context('with valid token') do
      it('should return the current user') do
        get('/api/v1/users/current', as: :json, headers: { Authorization: token })
        expect(json['payload']['user_name']).to eql('username')
      end
    end

    context('with invalid token') do
      it('should return unauthorized status code') do
        get('/api/v1/users/current', as: :json, headers: { Authorization: 'invalid token' })
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('with no token') do
      it('should return unauthorized status code') do
        get('/api/v1/users/current')
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
