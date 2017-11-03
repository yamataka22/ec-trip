class Admin::ManagersController < Admin::AdminBase
  def index
    @managers = Manager.order(:id)
  end

  def new
    @manager = Manager.new
  end

  def create
    @manager = Manager.new(post_params)
    if @manager.save
      flash[:success] = '登録が完了しました'
      redirect_to admin_managers_path
    else
      flash.now[:error] = '入力内容をご確認ください'
      render :new
    end
  end

  def edit
    @manager = Manager.find(params[:id])
  end

  def update
    @manager = Manager.find(params[:id])
    @manager.assign_attributes(post_params)
    if params[:manager][:password].present?
      # パスワード変更時
      @manager.password = params[:manager][:password]
      @manager.password_confirmation = params[:manager][:password_confirmation]
    end
    if @manager.save
      flash[:success] = '更新が完了しました'
      redirect_to admin_managers_path
    else
      flash.now[:error] = '入力内容をご確認ください'
      render :edit
    end
  end

  def destroy
    manager = Manager.find(params[:id])
    if manager.id == current_manager.id
      flash[:error] = '自アカウントを削除することはできません'
    else
      manager.destroy!
      flash[:success] = '削除が完了しました'
    end
    redirect_to admin_managers_path
  end

  private
  def post_params
    params.require(:manager).permit(:last_name, :first_name, :email, :mail_accept)
  end
end
