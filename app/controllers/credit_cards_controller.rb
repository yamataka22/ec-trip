class CreditCardsController < FrontBase
  before_action :authenticate_member!
  layout 'account'

  def index
    @credit_cards = current_member.credit_cards.all
  end

  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = current_member.credit_cards.build
    respond_to do |format|
      if @credit_card.token_save(params[:stripe_token])
        @credit_cards = current_member.credit_cards.all
        format.js
      else
        format.js {render :new}
      end
    end
  end

  def destroy
    current_member.credit_cards.find(params[:id]).destroy
    flash[:success] = '削除が完了しました'
    redirect_to member_credit_cards_path
  end

end
