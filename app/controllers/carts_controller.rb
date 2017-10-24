class CartsController < FrontBase
  before_action :authenticate_member!
  layout 'mypage'

  def index
    @carts = current_member.carts.order(updated_at: :desc)
  end

  def create
    Cart.add_item(current_member, params[:item_id])
    redirect_to item_path(id: params[:item_id], cart_added: true)
  end

  def update
    cart = current_member.carts.find(params[:id])
    cart.quantity = params[:cart][:quantity]
    cart.save!
    flash[:success] = "#{cart.item.name} の数量を変更しました。"
    redirect_to action: :index
  end

  def destroy
    cart = current_member.carts.find(params[:id])
    cart.destroy!
    flash[:success] = "#{cart.item.name} はカートから削除されました。"
    redirect_to action: :index
  end
end
