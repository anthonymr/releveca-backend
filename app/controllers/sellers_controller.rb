class SellersController < ApplicationController
    rescue_from(ActiveRecord::RecordNotFound) { |e| not_found(e.message) }

    def index
        ok(Seller.mine, 'Sellers retrieved successfully')
    end

    def show
        ok(seller, 'Seller retrieved successfully')
    end

    private

    def seller
        @seller ||= Seller.find(params[:id])
    end
end