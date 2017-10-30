class Admin::ItemsController < Admin::AdminBase
  def index
    @search_form = Admin::ItemSearchForm.new(search_params)
    @items = @search_form.search(params[:page])
    session['search_params'] = view_context.search_conditions_keeper(params, [:category_id, :name, :order_type])
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(post_params)

    if @item.invalid?
      flash.now[:error] = '入力内容をご確認ください'
      render :new
    else
      if @item.preview.present?
        set_preview
        render :new
      else
        @item.save!
        flash[:success] = '登録が完了しました'
        redirect_to admin_items_path(session['search_params'])
      end
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.assign_attributes(post_params)

    if @item.invalid?
      flash.now[:error] = '入力内容をご確認ください'
      render :edit
    else
      if @item.preview.present?
        set_preview
        render :edit
      else
        @item.save!
        flash[:success] = '登録が完了しました'
        redirect_to admin_items_path(session['search_params'])
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.unpublished?
      @item.destroy
      flash[:success] = '削除が完了しました'
      redirect_to admin_items_path(session['search_params'])
    else
      flash[:error] = '公開後の商品を削除することはできません。ステータスを販売終了にしてください。'
      redirect_to admin_items_path(session['search_params'])
    end
  end

  def preview
    Item
    @item = Preview.find_by(manager: current_manager).content
    render '/items/show', layout: 'front'
  end

  private
  def search_params
    return  nil if params[:search].nil?
    params.require(:search).permit(:category_id, :name, :sort_type)
  end

  def post_params
    params.require(:item).permit(:name, :description, :caption_image_id, :about, :category_id,
                                    :price, :stock_quantity, :remarks, :status, :preview)
  end

  def set_preview
    preview = Preview.find_or_initialize_by(manager: current_manager)
    preview.content = @item
    preview.save!
  end
end
