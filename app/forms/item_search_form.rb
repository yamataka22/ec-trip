class ItemSearchForm
  include ActiveModel::Model

  attr_accessor :category_id, :pickup, :arrival_new, :keyword, :price_floor, :price_ceil, :sold_out, :sort_type

  def search(page, count: false)
    items = Item.includes(:caption_image).published
    items = items.where('`stock_quantity` > 0').where(status: :selling) if sold_out.blank? || sold_out == '0'
    # Rootのカテゴリが指定された場合、その子のカテゴリも対象とする
    if category_id.present?
      categories = [category_id].concat(Category.where(root_category_id: category_id).select(:id))
      items = items.left_joins(:category_items).where(category_items: {category_id: categories}).uniq
    end
    if pickup == '1' && arrival_new == '1'
      items = items.where('`items`.`pickup` = 1 OR `items`.`arrival_new` = 1')
    elsif pickup == '1'
      items = items.where(pickup: true)
    elsif arrival_new == '1'
      items = items.where(arrival_new: true)
    end
    items = items.where('`items`.`name` like ?', "%#{keyword}%") if keyword.present?
    items = items.where('`price` >= ?', price_floor) if price_floor.present?
    items = items.where('`price` <= ?', price_ceil) if price_ceil.present?
    if count
      items = items.count
    else
      items = items.page(page).per(20)
      case sort_type
        when 'price_desc'
          items = items.order(price: :desc, id: :desc)
        when 'price_asc'
          items = items.order(price: :asc, id: :desc)
        else
          items = items.order(id: :desc)
      end
    end
    items
  end

end