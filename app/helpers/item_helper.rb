module ItemHelper
  def setup_category_items(item)
    Category.all.each do |category|
      unless item.category_items.select{ |c| c.category_id == category.id }.any?
        item.category_items.build({ category_id: category.id })
      end
    end
    item
  end

  def setup_category_items_attributes(params)
    # キーが数字の文字列のhashになっていたため配列にする "0" => {id: 1}
    attrs = params[:categorizations_attributes].dup.map{ |k, v| v }
    params[:category_items_attributes] = attrs.inject([]) { |res, attr|
      if attr[:apply].to_i == 0
        res.push({ id: attr[:id], _destroy: 1 }) if attr[:id].persent?
      else
        res.push({ id: attr[:id], category_id: attr[:category_id] })
      end
      res
    }
    params
  end
end