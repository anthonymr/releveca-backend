class Bank < ApplicationRecord
  has_many :payments, dependent: :restrict_with_error
  belongs_to :corporation
  belongs_to :currency

  validates :name, presence: true, uniqueness: true
end