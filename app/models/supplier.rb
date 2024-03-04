class Supplier < ApplicationRecord
    has_many :warranties
    belongs_to :corporation

    def self.mine
        Supplier.where(corporation_id: Current.corporation.id)
    end
end