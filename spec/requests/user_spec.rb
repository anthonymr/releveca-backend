require 'rails_helper'

RSpec.describe('User', type: :request) do
  describe 'POST /api/v1/users' do
    let!(:existing_user) { FactoryBot.create(:user) }
    let!(:params) { new_user_params }

    context 'with valid parameters' do
      before { post '/api/v1/users', params: }

      it 'creates an user' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'returns a unprocessable entity status when no password' do
        params[:password] = ''
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when no name' do
        params[:name] = ''
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when no last_name' do
        params[:last_name] = ''
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when no email' do
        params[:email] = ''
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when no user_name' do
        params[:user_name] = ''
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with duplicated parameters' do
      it 'returns a unprocessable entity status when duplicated user_name' do
        params[:user_name] = existing_user.user_name
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when duplicated email' do
        params[:email] = existing_user.email
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

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
