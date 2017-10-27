class ItemsController < FrontBase
  def index
  end

  def show
    @item = Item.published.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end
end
