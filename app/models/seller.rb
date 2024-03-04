class Seller < ApplicationRecord
    has_many :warranties
    belongs_to :corporation

    def self.mine
        all
    end
end