class Warranty < ApplicationRecord
    belongs_to :corporation
    belongs_to :client
    belongs_to :user
    belongs_to :item

    def mine?
        corporation == Current.corporation
    end

    def self.mine
        Current.corporation.warranties
    end
end