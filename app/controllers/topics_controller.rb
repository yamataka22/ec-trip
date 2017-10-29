class TopicsController < FrontBase
  def index
    @topics = Topic.all.page(params[:page]).per(30).order(id: :desc)
  end
end
