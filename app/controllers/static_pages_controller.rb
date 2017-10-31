class StaticPagesController < FrontBase
  def show
    @static_page = StaticPage.find_by(name: params[:name], published: true)
  end
end
