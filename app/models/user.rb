class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :corporations
  belongs_to :current_corporation, class_name: 'Corporation', optional: true
  has_many :orders, dependent: :restrict_with_error
  has_many :order_histories, dependent: :restrict_with_error

  validates :email, presence: true, uniqueness: true, length: { minimum: 8, maximum: 50 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_digest, presence: true
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :user_name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :status, presence: true, inclusion: { in: %w[enabled disabled] }, length: { minimum: 3, maximum: 20 }

  def no_password
    attributes.except('password_digest')
  end

  def enable?
    status == 'enabled'
  end

  def self.all_no_password
    select(:id, :name, :last_name, :user_name, :email)
  end
end
