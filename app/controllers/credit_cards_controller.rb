class CreditCardsController < FrontBase
  before_action :authenticate_member!
  layout 'account'

  def index
    if current_member.credit_cards.blank?
      redirect_to new_member_credit_card_path(purchase: params[:purchase]) and return
    end
    @credit_cards = current_member.credit_cards.all
    render '/purchases/credit_cards/index', layout: 'purchase' if params[:purchase].present?
  end

  def new
    @credit_card = CreditCard.new
  end

  def create
    @credit_card = current_member.credit_cards.build

    save_success = @credit_card.token_save(params[:stripe_token])
    if params[:purchase].present?
      if save_success
        respond_to do |format|
          format.js {render '/purchases/credit_cards/create' }
          format.html {redirect_to new_purchase_path(credit_card_id: @credit_card.id)}
        end
      else
        respond_to do |format|
          format.js {render '/purchases/credit_cards/new' }
          format.html {render '/purchases/credit_cards/new', layout: 'purchase' }
        end
      end
    else
      if save_success
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
  end

  def destroy
    current_member.credit_cards.find(params[:id]).destroy
    flash[:success] = '削除が完了しました'
    redirect_to member_credit_cards_path
  end

end
