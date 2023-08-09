require 'rails_helper'

RSpec.describe('Clients', type: :request) do
  describe('GET /clients') do
    let!(:token) { simulate_login }
    let!(:headers) { header_builder(token) }
    let!(:corporation) { select_corporation(token) }
    let!(:client) { FactoryBot.create(:client) }
    let!(:my_clients) { FactoryBot.create_list(:client, 5, corporation:, user: @user) }
    let!(:other_clients) { FactoryBot.create_list(:client, 5, corporation:) }
    let!(:route) { clients_path }

    context('when user is logged in') do
      context('it should return only my clients') do
        before do
          get(route, as: :json, headers:)
        end

        it('returns ok status code') do
          expect(response).to(have_http_status(:ok))
        end

        it('returns an array of clients') do
          expect(json['payload']['items']).not_to(be_empty)
        end

        it('returns only clients from the user corporation') do
          expect(json['payload']['items'].length).to(eq(my_clients.length))
        end
      end
    end

    context('when user is not logged in') do
      before do
        get(route, as: :json)
      end

      it('returns unauthorized status code') do
        expect(response).to(have_http_status(:unauthorized))
      end
    end
  end
end
