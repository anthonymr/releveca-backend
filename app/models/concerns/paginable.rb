module Paginable
  extend ActiveSupport::Concern

  def paginate(items, page, count = 10)
    sliced = items.each_slice(count.to_i).to_a
    real_page = page.to_i - 1
    next_page = sliced.size < real_page + 2 ? real_page + 2 : real_page.next
    previous_page = real_page.zero? ? 0 : real_page

    pagination = {
      pages: sliced.size,
      current_page: page.to_i,
      next_page: next_page.to_s,
      previous_page: previous_page.to_s
    }

    return { pagination:, items: sliced.last } if real_page.next > sliced.size

    { pagination:, items: items.each_slice(count.to_i).to_a[real_page] }
  end
end
