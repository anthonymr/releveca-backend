require 'rails_helper'

RSpec.describe('Corporations', type: :request) do
  describe('PATCH /api/v1/corporations/:id/status') do
    let!(:token) { simulate_login }
    let!(:corporation) { select_corporation(token) }
    let!(:route) { corporation_change_status_path(corporation) }

    context('with valid token and parameters') do
      it('changes status to enabled correctly') do
        patch(route, headers: { Authorization: token }, params: { status: 'enabled' })
        expect(response).to(have_http_status(:success))
        expect(json['payload']['status']).to(eq('enabled'))
      end

      it('changes status to disabled correctly') do
        patch(route, headers: { Authorization: token }, params: { status: 'disabled' })
        expect(response).to(have_http_status(:success))
        expect(json['payload']['status']).to(eq('disabled'))
      end
    end

    context('with valid token and invalid parameters') do
      it('returns unprocessable_entity code') do
        patch(route, headers: { Authorization: token }, params: { status: '' })
        expect(response).to(have_http_status(:unprocessable_entity))
      end
    end

    context('with no token and valid parameters') do
      it('returns unauthorized code') do
        patch(route, params: { status: 'enabled' })
        expect(response).to(have_http_status(:unauthorized))
      end
    end

    context('with invalid token and valid parameters') do
      it('returns unauthorized code') do
        patch(route, params: { status: 'enabled' }, headers: { Authorization: 'invalid token' })
        expect(response).to(have_http_status(:unauthorized))
      end
    end
  end
end
