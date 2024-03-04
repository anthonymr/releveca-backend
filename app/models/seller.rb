class Seller < ApplicationRecord
    has_many :warranties
    belongs_to :corporation

    def self.mine
        Seller.where(corporation_id: Current.corporation.id)
    end

end