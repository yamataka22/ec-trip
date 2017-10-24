class ItemsController < FrontBase
  def index
  end

  def show
    @item = Item.published.find(params[:id])
  end
end
