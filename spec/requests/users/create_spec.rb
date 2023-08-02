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

    context 'with missing parameters' do
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

    context 'with invalid parameters' do
      it 'returns a unprocessable entity status when invalid email' do
        params[:email] = 'invalid email'
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when email is to short' do
        params[:email] = 'a@a.a'
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when email is to long' do
        params[:email] = "a@a.#{'a' * 50}"
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when name is to short' do
        params[:name] = 'a'
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when name is to long' do
        params[:name] = 'a' * 51
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when last_name is to short' do
        params[:last_name] = 'a'
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when last_name is to long' do
        params[:last_name] = 'a' * 51
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when user_name is to short' do
        params[:user_name] = 'a'
        post('/api/v1/users', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a unprocessable entity status when user_name is to long' do
        params[:user_name] = 'a' * 51
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
end
