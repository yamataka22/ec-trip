class Order::PurchasesController < FrontBase
  before_action :authenticate_member!, except: [:new, :complete]
  layout 'order'

  def new
    redirect_to sign_in_order_guests_path and return unless member_signed_in?
    redirect_to carts_path and return if current_member.carts.blank? || current_member.carts.find {|cart| cart.item_error.present? }

    session[:purchase] ||= {}
    session[:purchase]['delivery_address_id'] = params[:delivery_address_id] if params[:delivery_address_id].present?
    session[:purchase]['credit_card_id'] = params[:credit_card_id] if params[:credit_card_id].present?

    redirect_to order_invoice_address_path and return if current_member.invoice_address.blank?
    redirect_to order_delivery_addresses_path and return if current_member.delivery_addresses.blank?
    redirect_to order_credit_cards_path and return if current_member.credit_cards.blank?

    @purchase = current_member.purchases.build
    @purchase.delivery_address_id = session[:purchase]['delivery_address_id'] || @purchase.member.main_address.id
    @purchase.credit_card_id = session[:purchase]['credit_card_id'] || @purchase.member.main_credit_card.id
    @purchase.set_attribute
  end

  def create
    @purchase = current_member.purchases.build
    @purchase.assign_attributes(post_params)
    if @purchase.new_order
      PurchaseCompleteJob.perform_later(@purchase)
      session[:purchase] = nil
      redirect_to complete_order_purchase_path(@purchase)
    else
      @purchase.set_amount
      render :new
    end
  end

  def complete
    if params[:cart_session_id]
      @purchase = Purchase.find_by(cart_session_id: params[:cart_session_id])
      raise ActiveRecord::RecordNotFound if @purchase.nil?
    else
      @purchase = current_member.purchases.find_by(id: params[:id])
    end
    render :complete, layout: 'front'
  end

  private
  def post_params
    params.require(:purchase).permit(
        :invoice_last_name, :invoice_first_name, :invoice_phone, :invoice_postal_code,
        :invoice_prefecture_id, :invoice_address1, :invoice_address2, :delivery_last_name, :delivery_first_name,
        :delivery_phone, :delivery_postal_code, :delivery_prefecture_id, :delivery_address1, :delivery_address2,
        :delivery_address_id, :credit_card_id,
        details_attributes: [:item_id, :quantity]
    )
  end

end
