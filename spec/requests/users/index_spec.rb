require 'rails_helper'

RSpec.describe('User', type: :request) do
  describe 'GET /api/v1/users' do
    let!(:token) { simulate_login }

    context 'With no web token' do
      it 'returns unauthorized status' do
        get '/api/v1/users'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'With valid web token' do
      before do
        get '/api/v1/users', as: :json, headers: { Authorization: token }
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a list of users' do
        expect(json['payload'].size).to eq(User.count)
      end

      it 'returns the correct user' do
        expect(json['payload'][0]['name']).to eq('example user')
      end

      it 'returns the right message' do
        expect(json['message']).to eq('Users retrieved successfully')
      end
    end

    context 'with invalid web token' do
      before do
        get '/api/v1/users', as: :json, headers: { Authorization: 'invalid token' }
      end

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
