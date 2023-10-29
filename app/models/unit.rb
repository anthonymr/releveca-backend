class Unit < ApplicationRecord
  belongs_to :corporation

  validates :name, presence: true, uniqueness: { scope: :corporation_id }, length: { maximum: 50, minimum: 2 }
  validates :code, presence: true, uniqueness: { scope: :corporation_id }, length: { maximum: 10, minimum: 2 }
  validates :corporation, presence: true
end