class Admin::CategoriesController < Admin::AdminBase
  def index
    @categories = Category.sorted_all(include_items: true)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create_with_auto_sequence(post_params)
    if @category.errors.present?
      flash.now[:error] = '入力内容をご確認ください'
      render action: :new
    else
      flash[:success] = '登録が完了しました'
      redirect_to admin_categories_path
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if params[:sequence_up].present?
      @category.sequence_up
      flash[:success] = '更新が完了しました'
      redirect_to admin_categories_path
    else
      @category.assign_attributes(post_params)
      if @category.update_with_auto_sequence
        flash[:success] = '更新が完了しました'
        redirect_to admin_categories_path
      else
        flash.now[:error] = '入力内容をご確認ください'
        render action: :edit
      end
    end
  end

  def destroy
    category = Category.find(params[:id])
    if category.destroy
      flash[:success] = '削除が完了しました'
    else
      flash[:error] = '対象のカテゴリには商品が登録されているため、削除できません'
    end
    redirect_to admin_categories_path
  end

  private
  def post_params
    params.require(:category).permit(:name, :root_category_id)
  end
end
