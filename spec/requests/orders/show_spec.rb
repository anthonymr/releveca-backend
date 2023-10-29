require 'rails_helper'

RSpec.describe('Orders', type: :request) do
  describe('GET /orders/:id') do
    let!(:token) { simulate_login }
    let!(:corporation) { select_corporation(token) }
    let!(:headers) { header_builder(token) }
    let!(:order) { FactoryBot.create(:order_with_details, corporation:, user: @user) }
    let!(:not_my_order) { FactoryBot.create(:order_with_details, corporation:) }
    let!(:route) { order_path(order) }

    context('when user is logged in') do
      before do
        get(route, headers:)
      end

      it('returns http ok status code') do
        expect(response).to(have_http_status(:ok))
      end

      it('returns order with details') do
        expect(json['payload']['order_details'].size).to(eq(order.order_details.size))
      end
    end

    context('when user is logged in but it is not my order') do
      it('returns http not found status code') do
        get(order_path(not_my_order), headers:)
        expect(response).to(have_http_status(:not_found))
      end
    end

    context('when user is not logged in') do
      it('returns http unauthorized status code') do
        get(route)
        expect(response).to(have_http_status(:unauthorized))
      end
    end
  end
end
