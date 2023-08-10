require 'rails_helper'

RSpec.describe('Orders', type: :request) do
  describe('GET /orders') do
    let!(:token) { simulate_login }
    let!(:corporation) { select_corporation(token) }
    let!(:headers) { header_builder(token) }
    let!(:orders) { FactoryBot.create_list(:order_with_details, 5, corporation:, user: @user) }
    let!(:other_orders) { FactoryBot.create_list(:order_with_details, 3, user: @user) }
    let!(:not_my_orders) { FactoryBot.create_list(:order_with_details, 1, corporation:) }
    let!(:route) { orders_path }

    context('when user is logged in') do
      before do
        get(route, headers:)
      end

      it('returns http ok status code') do
        expect(response).to(have_http_status(:ok))
      end

      it('returns only orders from current corporation') do
        expect(json['payload'].size).to(eq(orders.size))
      end

      it('returns orders with details') do
        expect(json['payload'].first['order_details'].size).to(eq(orders.first.order_details.size))
      end

      it('returns orders with client') do
        expect(json['payload'].first['client']).to(be_present)
      end

      it('returns orders with currency') do
        expect(json['payload'].first['currency']).to(be_present)
      end

      it('returns orders with payment condition') do
        expect(json['payload'].first['payment_condition']).to(be_present)
      end

      it('returns orders with user') do
        expect(json['payload'].first['user']).to(be_present)
      end

      it('has all its parameters') do
        expect(json['payload'].first.keys)
          .to(include(
            'id',
            'sub_total',
            'taxes',
            'total',
            'rate',
            'status',
            'approved',
            'index',
            'balance',
            'payment_condition_id',
            'client_id',
            'currency_id',
            'created_at',
            'updated_at',
            'user_id',
            'corporation_id',
            'client',
            'user',
            'currency',
            'payment_condition',
            'order_details'
          ))
      end

      it('returns valid details') do
        expect(json['payload'].first['order_details'].first.keys)
          .to(include(
            'id',
            'qty',
            'unit_price',
            'total_price',
            'order_id',
            'item_id',
            'currency_id',
            'created_at',
            'updated_at',
            'item'
          ))
      end
    end

    context('when user is not logged in') do
      before do
        get(route)
      end

      it('returns http unauthorized status code') do
        expect(response).to(have_http_status(:unauthorized))
      end
    end
  end
end
