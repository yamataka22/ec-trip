class CartsController < FrontBase
  layout :set_layout
  before_action :find_cart, only: [:update, :destroy]

  def index
    if member_signed_in?
      @carts = current_member.carts.order(:id)
    else
      @carts = Cart.where(member: nil, session_id: cart_session_id).order(:id)
    end
  end

  def create
    if Cart.add_item(params[:item_id], current_member, cart_session_id)
      redirect_to item_path(id: params[:item_id], cart_added: true)
    else
      flash[:error] = 'カートに商品を追加することができませんでした。'
      redirect_to item_path(id: params[:item_id])
    end
  end

  def update
    if @cart.update_quantity(params[:cart][:quantity].to_i)
      flash[:success] = "#{@cart.item.name} の数量を変更しました。"
    else
      flash[:error] = '数量を変更することができません。'
    end

    redirect_to carts_path
  end

  def destroy
    @cart.destroy!
    flash[:success] = "#{@cart.item.name} はカートから削除されました。"
    redirect_to action: :index
  end

  private
  def set_layout
    if member_signed_in?
      'mypage'
    else
      'front'
    end
  end

  def cart_session_id
    if session[:cart_session_id].blank?
      session[:cart_session_id] = SecureRandom.uuid
    end
    session[:cart_session_id]
  end

  def find_cart
    if member_signed_in?
      @cart = current_member.carts.find(params[:id])
    else
      @cart = Cart.find_by(member: nil, session_id: cart_session_id)
      raise ActiveRecord::RecordNotFound if @cart.nil?
    end
  end
end
