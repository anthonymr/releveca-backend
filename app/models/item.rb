class Item < ApplicationRecord
  belongs_to :corporation
  has_many :order_details, dependent: :restrict_with_error

  validates :code, presence: true, length: { maximum: 50 }
  validates :name, presence: true, length: { maximum: 250 }
  validates :model, length: { maximum: 50 }
  validates :stock, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :unit, presence: true, length: { maximum: 10 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :index, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :corporation, presence: true
  validates :status, presence: true, inclusion: { in: %w[enabled disabled] }

  before_validation :set_defaults

  def set_defaults
    self.stock ||= 0
    self.status ||= 'enabled'
  end

  class << self
    def mine
      Current.corporation&.items
    end

    def mine_filtered(str = '')
      str ||= ''
      return Item.mine if str.empty?

      Item.mine.where('name ILIKE ? OR code ILIKE ?', "%#{str}%", "%#{str}%")
    end

    def mine_enabled
      Item.mine&.where(status: 'enabled')
    end
  end
end
