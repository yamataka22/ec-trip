class Member::CreditCardsController < FrontBase
  before_action :authenticate_member!
  layout 'account'

  def index
    if current_member.credit_cards.blank?
      redirect_to new_member_credit_card_path(purchase: params[:purchase]) and return
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
        format.js {@credit_cards = current_member.credit_cards.all}
        format.html do
          flash[:success] = '登録が完了しました'
          redirect_to member_credit_cards_path
        end
      end
    else
      respond_to do |format|
        format.js {render :new}
        format.html {render :new}
      end
    end
  end

  def destroy
    current_member.credit_cards.find(params[:id]).destroy
    flash[:success] = '削除が完了しました'
    redirect_to member_credit_cards_path
  end

  def change_main
    current_member.main_credit_card_id = params[:id]
    current_member.save
    flash[:success] = '規定のカードを変更しました'
    redirect_to member_credit_cards_path
  end

end
