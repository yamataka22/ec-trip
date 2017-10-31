class Admin::StaticPagesController < Admin::AdminBase
  def index
    @static_pages = StaticPage.all.order(:id)
  end

  def new
    @static_page = StaticPage.new
  end

  def create
    @static_page = StaticPage.new(post_params)
    if @static_page.invalid?
      flash.now[:error] = '入力内容をご確認ください'
      render :new
    else
      if @static_page.preview.present?
        set_preview
        render :new
      else
        @static_page.save!
        flash[:success] = '登録が完了しました'
        redirect_to admin_static_pages_path
      end
    end
  end

  def edit
    @static_page = StaticPage.find(params[:id])
  end

  def update
    @static_page = StaticPage.find(params[:id])
    @static_page.assign_attributes(post_params)

    if @static_page.invalid?
      flash.now[:error] = '入力内容をご確認ください'
      render :edit
    else
      if @static_page.preview.present?
        set_preview
        render :edit
      else
        @static_page.save!
        flash[:success] = '更新が完了しました'
        redirect_to admin_static_pages_path
      end
    end
  end

  def destroy
    static_page = StaticPage.find(params[:id])
    static_page.destroy!
    flash[:success] = '削除が完了しました'
    redirect_to admin_static_pages_path
  end

  def preview
    StaticPage
    preview = Preview.find_by(params[:preview_id])
    @static_page = preview.content
    preview.destroy!
    render '/static_pages/show', layout: 'front'
  end

  private
  def post_params
    params.require(:static_page).permit(:name, :title, :content, :published, :preview)
  end

  def set_preview
    @preview_id = Preview.create(content: @static_page).id
  end

end
