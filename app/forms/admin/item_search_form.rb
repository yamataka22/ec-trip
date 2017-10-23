class Admin::ItemSearchForm
  include ActiveModel::Model

  attr_accessor :category_id, :name, :sort_type

  def search(page)
    items = Item.includes(:category)
    items = items.where(category_id: category_id) if category_id.present?
    items = items.where('`items`.`name` like ?', "%#{name}%") if name.present?
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