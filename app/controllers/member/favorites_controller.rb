class Member::FavoritesController < FrontBase
  before_action :authenticate_member!
  layout 'mypage'

  def index
    @items = Item.joins(:favorites).where(favorites: {member_id: current_member.id})#.order(favorites: {created_at: :desc})
  end

  def create
    @favorite = current_member.favorites.where(item_id: params[:item_id]).first
    if @favorite
      @favorite.destroy!
      respond_to do |format|
        format.js { render :delete }
      end
    else
      @favorite = current_member.favorites.create(item_id: params[:item_id])
      respond_to do |format|
        format.js { render :new }
      end
    end
  end

end
