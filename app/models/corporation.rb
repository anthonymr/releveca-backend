class Corporation < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :items, dependent: :restrict_with_error
  has_many :clients, dependent: :restrict_with_error
  has_many :payment_conditions, dependent: :restrict_with_error
  belongs_to :base_currency, class_name: 'Currency'
  belongs_to :default_currency, class_name: 'Currency'

  validates :name, presence: true, uniqueness: true, length: { maximum: 50, minimum: 2 }
  validates :rif, presence: true, uniqueness: true, length: { maximum: 15 },
                  format: { with: /\A[VEJPG]{1}[0-9]{5,9}\z/ }
  validates :address, presence: true, length: { maximum: 100, minimum: 4 }
  validates :phone, length: { maximum: 15 }
  validates :email, length: { maximum: 50 }, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :website, length: { maximum: 50 }, allow_blank: true
  validates :status, presence: true, inclusion: { in: %w[enabled disabled] }, length: { minimum: 3, maximum: 20 }
  validates :base_currency, presence: true
  validates :default_currency, presence: true

  def self.all_enabled
    all.where(status: 'enabled')
  end

  def enabled?
    status == 'enabled'
  end
end
