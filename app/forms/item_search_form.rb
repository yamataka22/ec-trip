class ItemSearchForm
  include ActiveModel::Model

  attr_accessor :category_id, :keyword, :price_floor, :price_ceil, :sold_out, :sort_type

  def search(page)
    items = Item.published
    items = items.where('`stock_quantity` > 0').where(status: :selling) if sold_out.blank? || sold_out == '0'
    items = items.where(category_id: category_id) if category_id.present?
    items = items.where('`items`.`name` like ?', "%#{keyword}%") if keyword.present?
    items = items.where('`price` >= ?', price_floor) if price_floor.present?
    items = items.where('`price` <= ?', price_ceil) if price_ceil.present?
    items = items.page(page).per(12)
    case sort_type
      when 'price_desc'
        items = items.order(price: :desc, id: :desc)
      when 'price_asc'
        items = items.order(price: :asc, id: :desc)
      else
        items = items.order(id: :desc)
    end
    items
  end

end