require 'rails_helper'

RSpec.describe('Items', type: :request) do
  describe('PUT /items/:id') do
    let!(:token) { simulate_login }
    let!(:headers) { header_builder(token) }
    let!(:corporation) { select_corporation(token) }
    let!(:item) { FactoryBot.create(:item, corporation:) }
    let!(:not_my_item) { FactoryBot.create(:item) }
    let!(:route) { item_path(item) }

    context('when user is logged in, params are valid and it is my item') do
      before do
        put(route, params: { name: 'New name' }, headers:)
      end

      it('returns ok status code') do
        expect(response).to(have_http_status(:ok))
      end

      it('returns a success message') do
        expect(json['message']).to(eq('Item updated successfully'))
      end

      it('returns the updated item') do
        expect(json['payload']['name']).to(eq('New name'))
      end
    end

    context('when user is logged in, params are valid and it is not my item') do
      before do
        put(item_path(not_my_item), params: { name: 'New name' }, headers:)
      end

      it('returns not_found status code') do
        expect(response).to(have_http_status(:not_found))
      end
    end

    context('when user is not logged in') do
      before do
        put(route, params: { name: 'New name' })
      end

      it('returns unauthorized status code') do
        expect(response).to(have_http_status(:unauthorized))
      end
    end
  end
end
