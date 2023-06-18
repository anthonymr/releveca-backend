class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, length: { minimum: 8, maximum: 50 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6, maximum: 20 }
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :user_name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
end
