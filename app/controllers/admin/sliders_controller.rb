class Admin::SlidersController < Admin::AdminBase
  def index
    if Slider.count == 0
      5.times {Slider.create}
    end
    @sliders = Slider.all
  end

  def edit
    @slider = Slider.find(params[:id])
  end

  def update
    @slider = Slider.find(params[:id])
    @slider.assign_attributes(post_params)

    if @slider.save
      flash[:success] = '更新が完了しました'
      redirect_to admin_sliders_path
    else
      flash.now[:error] = '入力内容をご確認ください'
      render :edit
    end
  end

  private
  def post_params
    params.require(:slider).permit(:title, :description, :link_url, :image_id, :caption_position, :caption_color, :published)
  end
end
