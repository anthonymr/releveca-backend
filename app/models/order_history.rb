class OrderHistory < ApplicationRecord
  belongs_to :order
  belongs_to :user

  validates :from, inclusion: { in: Setting.history_statuses }
  validates :from, presence: true
  validates :to, inclusion: { in: Setting.history_statuses }
  validates :to, presence: true
end
