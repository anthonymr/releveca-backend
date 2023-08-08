require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe('GET /api/v1/auth') do
    context 'when user is logged in' do
      let!(:token) { simulate_login }

      before do
        get('/api/v1/auth', as: :json, headers: { Authorization: token })
      end

      it 'returns ok code' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns user data' do
        expect(json['payload']['user_name']).to eq('username')
      end
    end

    context 'when user is not logged in' do
      it 'returns unauthorized code' do
        get('/api/v1/auth')
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when token is invalid' do
      it 'returns unauthorized code' do
        get('/api/v1/auth', as: :json, headers: { Authorization: 'Invalid token' })
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
