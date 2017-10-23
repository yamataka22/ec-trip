class TopController < FrontBase
  def index
    @items = Item.published.limit(12).order(id: :desc)
    @favorites = current_member.favorites.where(item: @items.map{|item| item.id}) if member_signed_in?
  end
end
