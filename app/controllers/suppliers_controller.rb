class SuppliersController < ApplicationController
    rescue_from(ActiveRecord::RecordNotFound) { |e| not_found(e.message) }

    def index
        ok(Supplier.mine.order(:code), 'Suppliers retrieved successfully')
    end

    def show
        ok(supplier, 'Supplier retrieved successfully')
    end

    private

    def supplier
        @supplier ||= Supplier.find(params[:id])
    end
end