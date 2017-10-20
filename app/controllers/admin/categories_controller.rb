class Admin::CategoriesController < Admin::AdminBase
  def index
    @categories = Category.all.order(:sequence)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(post_params)
    @category.sequence = Category.maximum(:sequence).to_i + 1
    if @category.save
      flash[:success] = '登録が完了しました'
      redirect_to admin_categories_path
    else
      flash.now[:error] = '入力内容をご確認ください'
      render action: :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if params[:seq_type].present?
      @category.change_sequence(params[:seq_type].to_sym)
      flash[:success] = '更新が完了しました'
      redirect_to admin_categories_path
    else
      @category.assign_attributes(post_params)
      if @category.save
        flash[:success] = '更新が完了しました'
        redirect_to admin_categories_path
      else
        flash.now[:error] = '入力内容をご確認ください'
        render action: :edit
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:success] = '削除が完了しました'
      redirect_to admin_categories_path
    else
      flash.now[:error] = @category.errors[:base]
      render action: :index
    end
  end

  private
  def post_params
    params.require(:category).permit(:name)
  end
end
