class Paginate < ApplicationService
  def initialize(items = [], page = 0, count = 10)
    super()
    @items = items
    @page = page
    @count = count
  end

  def call
    {
      pagination: {
        total_items: @items.size,
        current_page: @page.to_i
      },
      items: @items.each_slice(@count.to_i).to_a[@page.to_i]
    }
  end
end
