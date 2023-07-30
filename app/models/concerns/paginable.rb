module Paginable
  extend ActiveSupport::Concern

  def paginate(items, page = 0, count = 10)
    {
      pagination: {
        total_items: items.size,
        current_page: page.to_i
      },
      items: items.each_slice(count.to_i).to_a[page.to_i]
    }
  end
end
