class CartsController < FrontBase
  before_action :authenticate_member!
  layout 'mypage'

  def index
    @carts = current_member.carts.order(updated_at: :desc)
  end

  def create
    unless Cart.add_item(current_member, params[:item_id])
      flash[:error] = 'カートに商品を追加することができません'
    end
    redirect_to item_path(id: params[:item_id], cart_added: true)
  end

  def update
    cart = current_member.carts.find(params[:id])
    cart.quantity = params[:cart][:quantity]
    cart.save!
    if Cart.add_item(current_member, params[:item_id], params[:cart][:quantity])
      flash[:success] = "#{cart.item.name} の数量を変更しました。"
    else
      flash[:error] = '数量を変更することができません。'
    end

    redirect_to member_carts_path
  end

  def destroy
    cart = current_member.carts.find(params[:id])
    cart.destroy!
    flash[:success] = "#{cart.item.name} はカートから削除されました。"
    redirect_to action: :index
  end
end
