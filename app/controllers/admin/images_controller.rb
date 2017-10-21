class Admin::ImagesController < Admin::AdminBase
  def new
    @image = Image.new
    @image.target_class = params[:target_class]
    respond_to {|format| format.js}
  end

  def create
    @image = Image.new(post_params)
    respond_to do |format|
      if @image.save
        format.js
      else
        format.js {render :new}
      end
    end
  end

  private
  def post_params
    params.require(:image).permit(:image, :target_class)
  end
end
