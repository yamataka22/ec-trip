class TopController < FrontBase
  def index
    @items = {}
    @items[:pickup] = Item.published.includes(:caption_image).where(pickup: true).order(id: :desc).limit(6)
    @items[:new] = Item.published.includes(:caption_image).where(arrival_new: true).order(id: :desc).limit(6)
    @favorites = current_member.favorites if member_signed_in?
    @topics = Topic.order(created_at: :desc).limit(10)
    @sliders = Slider.where(published: true).order(:id)
    render '/top'
  end
end
