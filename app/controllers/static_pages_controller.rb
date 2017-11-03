class StaticPagesController < FrontBase
  def show
    @static_page = StaticPage.find_by(name: params[:name], published: true)
    raise ActiveRecord::RecordNotFound if @static_page.nil?
  end
end
