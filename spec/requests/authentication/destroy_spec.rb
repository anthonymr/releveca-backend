require 'rails_helper'

RSpec.describe('Authentication', type: :request) do
  describe('DELETE /api/v1/auth') do
    context('with valid token') do
      let!(:token) { simulate_login }
      before do
        delete('/api/v1/auth', headers: { Authorization: token })
      end

      it('should return no ok code') do
        expect(response).to have_http_status(:ok)
      end

      it('should return the right message') do
        expect(json['message']).to eql('Logged out')
      end
    end

    context('with invalid token') do
      let!(:token) { 'invalid token' }

      it('should return unauthorized status code') do
        delete('/api/v1/auth', headers: { Authorization: token })
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('with no token') do
      it('should return unauthorized status code') do
        delete('/api/v1/auth')
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('with expired token') do
      let!(:token) do
        payload = { user_name: 'username', exp: Time.now.to_i - 10 }
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
      end

      it('should return unauthorized status code') do
        delete('/api/v1/auth', headers: { Authorization: token })
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
