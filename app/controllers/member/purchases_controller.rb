class Member::PurchasesController < FrontBase
  before_action :authenticate_member!
  layout 'mypage'

  def index
    @purchases = current_member.purchases.order(created_at: :desc)
  end

  def show
    @purchase = current_member.purchases.find(params[:id])
    render layout: nil
  end

end
