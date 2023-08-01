class Client < ApplicationRecord
  belongs_to :user
  belongs_to :corporation
  has_many :orders, dependent: :restrict_with_error

  validates :code, presence: true, length: { maximum: 50 }, uniqueness: { scope: :corporation_id }
  validates :client_type, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :name, presence: true, length: { maximum: 250 }
  validates :phone, presence: true, length: { maximum: 50 }
  validates :status, presence: true, length: { maximum: 50 }, inclusion: { in: %w[enabled disabled] }
  validates :notes, length: { maximum: 500 }
  validates :address, presence: true, length: { maximum: 500 }
  validates :taxpayer, inclusion: { in: [true, false] }
  validates :approval, inclusion: { in: [true, false] }
  validates :nit, length: { maximum: 15 }
  validates :email, length: { maximum: 50 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :index, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :country_id, presence: true
  validates :user_id, presence: true
  validates :rif, presence: true, length: { maximum: 15 }, uniqueness: { scope: :corporation_id },
                  format: { with: /\A[VEJPG]{1}[0-9]{5,9}\z/ }

  def mine?
    user_id == Current.user.id
  end

  def approved?
    approval
  end

  class << self
    def mine # currents
      Current.user&.clients
    end

    def mine_filtered(str = nil) # currents_search
      return Client.mine unless str

      Client.mine.where('name ILIKE ? OR rif ILIKE ?', "%#{str}%", "%#{str}%")
    end

    def mine_paginated(page = nil, count = 10, str = '') #currents_page
      Paginate.call(Client.mine_filtered(str), page, count)
    end

    def mine_enabled #currents_enabled
      Item.mine&.where(approval: true)
    end
  end
end
