class Admin::ImagesController < Admin::AdminBase

  def new
    @image = Image.new
    @image.target_class = params[:target_class]
    respond_to {|format| format.js}
  end

  def create
    image = Image.new(image: params[:file])

    if image.save
      render json: {
          image: {
              url: image.public_url(params[:size_type]).to_s,
              id: image.id.to_s,
              width: '100%'
          }
      }, content_type: 'text/html'
    else
      render json: {
          error_message: image.errors.messages[0]
      }, content_type: 'text/html'
    end
  end

  private
  def post_params
    params.require(:image).permit(:image, :target_class)
  end
end
