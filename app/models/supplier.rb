class Supplier < ApplicationRecord
    has_many :warranties

    def self.mine
        all
    end
end