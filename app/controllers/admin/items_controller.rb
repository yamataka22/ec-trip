class Admin::ItemsController < Admin::AdminBase
  before_action :process_category_items_attrs, only: [:create, :update]

  def index
    @search_form = Admin::ItemSearchForm.new(search_params)
    @search_form.stock_type = :less if @search_form.stock_type.blank?
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
    preview = Preview.find_by(params[:preview_id])
    @item = preview.content
    preview.destroy!
    render '/items/show', layout: 'front'
  end

  private
  def search_params
    return  nil if params[:search].nil?
    params.require(:search).permit(:category_id, :name, :sort_type, :stock_quantity, :stock_type, statuses: [])
  end

  def post_params
    params.require(:item).permit(:name, :description, :caption_image_id, :about,
                                 :price, :stock_quantity, :remarks, :status, :pickup, :arrival_new, :preview,
                                 category_items_attributes: [:id, :category_id, :enable, :_destroy])
  end

  def set_preview
    @preview_id = Preview.create(content: @item).id
  end

  def process_category_items_attrs
    params[:item][:category_items_attributes].values.each do |cat_attr|
      cat_attr[:_destroy] = true if cat_attr[:enable] != '1'
    end
  end
end
