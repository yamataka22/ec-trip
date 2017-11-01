class Admin::MembersController < Admin::AdminBase
  def index
    @search_form = Admin::MemberSearchForm.new(search_params)
    @members = @search_form.search(params[:page])
    session[:search_params] = view_context.search_conditions_keeper(params, [:email, :account_name, :created_at_from, :created_at_to, :leaved])
  end

  def show
    @member = Member.find(params[:id])
  end

  def destroy
    @member = Member.find(params[:id])
    @member.leave
    flash[:success] = '退会処理が完了しました'
    redirect_to admin_members_path(session[:search_params])
  end

  private
  def search_params
    return  nil if params[:search].nil?
    params.require(:search).permit(:email, :account_name, :created_at_from, :created_at_to, :leaved)
  end
end
