class CartsController < FrontBase
  before_action :authenticate_member!

  def index
  end

  def create
    Cart.add_item(current_member, params[:item_id])
    redirect_to item_path(id: params[:item_id], cart_added: true)
  end
end
