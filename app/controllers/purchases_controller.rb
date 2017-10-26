class PurchasesController < FrontBase
  before_action :authenticate_member!
  layout 'purchase'

  def index
  end

  def new
    redirect_to member_carts_path and return if current_member.carts.blank?

    session[:purchase] ||= {}
    if params[:delivery_address_id].present? &&
        current_member.delivery_addresses.map {|address| address.id}.include?(params[:delivery_address_id])
      session[:purchase][:delivery_address_id] = params[:delivery_address_id]
    end
    if params[:credit_card_id].present? &&
        current_member.credit_cards.map {|card| card.id}.include?(params[:credit_card_id])
      session[:purchase][:credit_card_id] = params[:credit_card_id]
    end

    if current_member.invoice_address.blank?
      redirect_to member_invoice_address_path(purchase: true)
    elsif current_member.delivery_addresses.blank?
      redirect_to member_delivery_addresses_path(purchase: true)
    elsif current_member.credit_cards.blank?
      redirect_to member_credit_cards_path(purchase: true)
    else
      @purchase = current_member.purchases.build
      if session[:purchase][:delivery_address_id]
        @purchase.delivery_address_id = session[:purchase][:delivery_address_id]
      else
        @purchase.delivery_address_id = current_member.main_address_id
      end
      if session[:purchase][:credit_card_id]
        @purchase.credit_card_id = session[:purchase][:credit_card_id]
      else
        @purchase.credit_card_id = current_member.main_credit_card_id
      end
      render :new
    end
  end

  def create

  end

  private
  def post_params

  end
end
