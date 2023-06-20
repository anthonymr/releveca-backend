class Country < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: /\A[A-Z\s]+\z/, message: "only allows uppercase and spaces" }
end
