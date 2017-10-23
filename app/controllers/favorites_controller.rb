class FavoritesController < FrontBase
  before_action :authenticate_member!

  def index
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
