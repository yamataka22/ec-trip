class Order::CreditCardsController < FrontBase
  before_action :authenticate_member!
  layout 'order'

  def index
    if current_member.credit_cards.blank?
      redirect_to new_order_credit_card_path and return
    end
    @credit_cards = current_member.credit_cards.all
  end

  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = current_member.credit_cards.build

    if @credit_card.token_save(params[:stripe_token])
      respond_to do |format|
        format.js {render :create }
        format.html {redirect_to new_order_purchase_path(credit_card_id: @credit_card.id)}
      end
    else
      respond_to do |format|
        format.js {render :new }
        format.html {render :new }
      end
    end
  end

end
