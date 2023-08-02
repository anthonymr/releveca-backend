require 'rails_helper'

RSpec.describe('User', type: :request) do
  let!(:token) { simulate_login }
  let!(:user) { FactoryBot.create(:user) }

  context('with valid token') do
    it('should update the user') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { name: 'new name' })
      expect(json['payload']['name']).to eql('new name')
    end
  end

  context('with invalid token') do
    it('should return unauthorized status code') do
      put('/api/v1/users', as: :json, headers: { Authorization: 'invalid token' }, params: { name: 'new name' })
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context('with no token') do
    it('should return unauthorized status code') do
      put('/api/v1/users', as: :json, params: { name: 'new name' })
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context('with missing arguments') do
    it('should return unprocessable_entity status code when no name') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { name: '' })
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('should return unprocessable_entity status code when no last_name') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { last_name: '' })
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('should return unprocessable_entity status code when no email') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { email: '' })
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('should return unprocessable_entity status code when no user_name') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { user_name: '' })
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context('with invalid arguments') do
    it('should return unprocessable_entity status code when name is too short') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { name: 'a' })
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('should return unprocessable_entity status code when name is too long') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { name: 'a' * 51 })
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('should return unprocessable_entity status code when last_name is too short') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { last_name: 'a' })
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('should return unprocessable_entity status code when last_name is too long') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { last_name: 'a' * 51 })
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('should return unprocessable_entity status code when email is invalid') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { email: 'invalid email' })
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('should return unprocessable_entity status code when user_name is too short') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { user_name: 'a' })
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('should return unprocessable_entity status code when user_name is too long') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { user_name: 'a' * 51 })
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context('with duplicated arguments') do
    it('should return unprocessable_entity status code when email is duplicated') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { email: user.email })
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it('should return unprocessable_entity status code when user_name is duplicated') do
      put('/api/v1/users', as: :json, headers: { Authorization: token }, params: { user_name: user.user_name })
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
