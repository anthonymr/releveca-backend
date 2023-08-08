require 'rails_helper'

RSpec.describe('Corporations', type: :request) do
  describe('POST /api/v1/corporations') do
    let!(:token) { simulate_login }
    let!(:route) { corporations_path }
    let!(:currency) { FactoryBot.create(:currency) }
    let!(:params) { new_corporation_params(currency) }

    context('when user is logged in') do
      before do
        post(route, as: :json, headers: { Authorization: token }, params:)
      end

      it('should create corporation') do
        expect(response).to have_http_status(:created)
        expect(json['payload']['name']).to eq(params[:name])
      end

      it('should have valid attributes') do
        expect(json['payload']['name']).to be_present
        expect(json['payload']['rif']).to be_present
        expect(json['payload']['address']).to be_present
        expect(json['payload']['base_currency_id']).to be_present
        expect(json['payload']['default_currency_id']).to be_present
      end
    end

    context('when user is not logged in') do
      it('should return unauthorized') do
        post(route, as: :json, params:)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context('when user is logged in but param is missing') do
      it('should return unprocessable_entity when name is missin') do
        params[:name] = nil
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when rif is missin') do
        params[:rif] = nil
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when address is missin') do
        params[:address] = nil
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when base_currency is missin') do
        params[:base_currency_id] = nil
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when default_currency is missin') do
        params[:default_currency_id] = nil
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context('when user is logged in but param is invalid') do
      it('should return unprocessable_entity when name is to long') do
        params[:name] = 'a' * 51
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when name is to short') do
        params[:name] = 'a'
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when rif has wrong format') do
        params[:rif] = 'INVALID_RIF'
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when rif has wrong format') do
        params[:rif] = '123456789'
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when rif is to long') do
        params[:rif] = "J#{'1' * 15}"
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when address is to long') do
        params[:address] = 'a' * 101
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when address is to short') do
        params[:address] = 'aaa'
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when phone is to long') do
        params[:phone] = '1' * 16
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when email is to long') do
        params[:email] = "#{'a' * 244}@example.com"
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when email has the wrong format') do
        params[:email] = 'testtest.com'
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when email has the wrong format') do
        params[:email] = 'test @test.com'
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when email has the wrong format') do
        params[:email] = 'test@.com'
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when website is to loong') do
        params[:website] = 'a' * 51
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context('when user is logged in but duplicated data') do
      let!(:existing_corporation) do
        FactoryBot.create(:corporation, rif: params[:rif], email: params[:email])
      end

      it('should return unprocessable_entity when rif is duplicated') do
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it('should return unprocessable_entity when email is duplicated') do
        post(route, as: :json, headers: { Authorization: token }, params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
