class Admin::PurchasesController < Admin::AdminBase
  def index
    @search_form = Admin::PurchaseSearchForm.new(search_params)
    @purchases = @search_form.search(params[:page])
    session[:search_params] = view_context.search_conditions_keeper(params, [:delivered, :email, :purchased_at_from, :purchased_at_to, :remarks])
  end

  def show
    @purchase = Purchase.includes(:details).find(params[:id])
    @before_purchase = Purchase.where('id < ?', @purchase.id).order(id: :desc).first
    @next_purchase = Purchase.where('id > ?', @purchase.id).order(:id).first
  end

  def update
    @purchase = Purchase.find(params[:id])
    @purchase.assign_attributes(post_params)
    if @purchase.save
      flash[:success] = '登録が完了しました'
      redirect_to admin_purchase_path(@purchase)
    else
      flash.now[:error] = '入力内容をご確認ください'
      render :show
    end
  end

  private
  def search_params
    return  nil if params[:search].nil?
    params.require(:search).permit(:undelivered, :email, :purchased_at_from, :purchased_at_to, :remarks)
  end

  def post_params
    params.require(:purchase).permit(:remarks, :delivered, :delivered_at)
  end
end
