class Admin::ItemSearchForm
  include ActiveModel::Model

  attr_accessor :category_id, :name, :sort_type, :stock_quantity, :stock_type, :statuses

  def search(page)
    items = Item.includes(:caption_image)
    # Rootのカテゴリが指定された場合、その子のカテゴリも対象とする
    if category_id.present?
      categories = [category_id].concat(Category.where(root_category_id: category_id).select(:id))
      items = items.left_joins(:category_items).where(category_items: {category_id: categories}).uniq
    end
    items = items.where('`items`.`name` like ?', "%#{name}%") if name.present?
    if stock_quantity.present?
      symbol = stock_type == 'less' ? '<=' : '>='
      items = items.where("`items`.`stock_quantity` #{symbol} ?", stock_quantity)
    end
    items = items.where(status: statuses) if statuses.present?

    items = items.page(page).per(50)
    case sort_type
      when 'asc'
        items = items.order(:id)
      when 'stock_desc'
        items = items.order(stock_quantity: :desc, id: :desc)
      when 'stock_asc'
        items = items.order(stock_quantity: :asc, id: :desc)
      else
        items = items.order(id: :desc)
    end
    items
  end

end