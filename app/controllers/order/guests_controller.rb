class Order::GuestsController < FrontBase
  before_action :sign_in?
  layout :set_layout

  def sign_in
    redirect_to new_member_session_path(purchase: true)
  end

  def new
    @purchase = Purchase.new(cart_session_id: session[:cart_session_id])
  end

  def confirm
    @purchase = Purchase.new(post_params)
    @purchase.set_guest_attribute
    if @purchase.invalid?
      flash.now[:error] = '入力内容をご確認ください'
      render :new
    end
  end

  def create
    @purchase = Purchase.new(post_params)
    if params[:page_back].present?
      render :new
    else
      if @purchase.new_order(params[:stripe_token])
        PurchaseCompleteJob.perform_later(@purchase)
        session[:cart_session_id] = nil
        redirect_to complete_order_purchase_path(@purchase, cart_session_id: @purchase.cart_session_id)
      else
        render :confirm
      end
    end
  end

  private
  def sign_in?
    redirect_to new_order_purchase_path if member_signed_in?
  end

  def set_layout
    if action_name == 'sign_in'
      'front'
    else
      'guest_order'
    end
  end

  def post_params
    params.require(:purchase).permit(
        :guest_email, :use_another_address, :cart_session_id,
        :invoice_last_name, :invoice_first_name, :invoice_phone, :invoice_postal_code,
        :invoice_prefecture_id, :invoice_address1, :invoice_address2, :delivery_last_name, :delivery_first_name,
        :delivery_phone, :delivery_postal_code, :delivery_prefecture_id, :delivery_address1, :delivery_address2,
        details_attributes: [:item_id, :quantity]
    )
  end

end