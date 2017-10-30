class TopController < FrontBase
  def index
    @items = {}
    @items[:pickup] = Item.where(pickup: true).order(id: :desc).limit(6)
    @items[:new] = Item.order(id: :desc).limit(6)
    @favorites = current_member.favorites if member_signed_in?
    @topics = Topic.order(created_at: :desc).limit(3)
    render '/top'
  end
end
