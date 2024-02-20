class Seller < ApplicationRecord
    has_many :warranties

    def self.mine
        all
    end
end