class Admin::ItemsController < Admin::AdminBase
  def index
    @items = Item.all.order(id: :desc)
  end

  def new
    @item = Item.new
    @image = Image.new
  end

  def edit
  end
end
