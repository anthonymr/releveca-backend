require 'rails_helper'

RSpec.describe('User', type: :request) do
  describe('get /api/v1/users/:id') do
    let!(:token) { simulate_login }
    let!(:existing_user) { FactoryBot.create(:user) }

    context('with valid token') do
      it('should return the user matching the id') do
        get("/api/v1/users/#{existing_user.id}", as: :json, headers: { Authorization: token })
        expect(json['payload']['id']).to eql(existing_user.id)
      end

      it('should return not_found status code if the id do not exists') do
        get('/api/v1/users/0', as: :json, headers: { Authorization: token })
        expect(response).to have_http_status(:not_found)
      end
    end

    context('with invalid token') do
      it('should return unauthorized status code') do
        get('/api/v1/users/0', as: :json, headers: { Authorization: 'Invalid token' })
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('with no token') do
      it('should return unauthorized status code') do
        get('/api/v1/users/0')
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
