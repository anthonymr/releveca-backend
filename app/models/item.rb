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

  class << self
    def currents
      Current.corporation&.items
    end

    def currents_search(str = '')
      return Item.currents if str.empty?

      Item.currents.where('name ILIKE ? OR code ILIKE ?', "%#{str}%", "%#{str}%")
    end

    def currents_page(page = nil, count = 12, str = '')
      Paginate.call(Item.currents_search(str), page, count)
    end

    def currents_enabled
      Item.currents&.where(status: 'enabled')
    end
  end
end
