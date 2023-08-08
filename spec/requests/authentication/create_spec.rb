require 'rails_helper'

RSpec.describe('Authentication', type: :request) do
  describe('POST /api/v1/auth') do
    before { simulate_login }

    context('with valid credentials') do
      it('should return a token') do
        post('/api/v1/auth', params: { user_name: 'username', password: 'password' })
        expect(json['payload']['token']).to be_present
      end
    end

    context('with invalid password') do
      it('should return unauthorized status code') do
        post('/api/v1/auth', params: { user_name: 'username', password: 'invalid password' })
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('with invalid user_name') do
      it('should return unauthorized status code') do
        post('/api/v1/auth', params: { user_name: 'invalid username', password: 'password' })
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
