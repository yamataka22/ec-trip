class MembersController < FrontBase
  before_action :authenticate_member!, except: :left
  layout 'account'

  def show
  end

  def update
    current_member.assign_attributes(post_params)

    if params[:member][:password].present?
      # パスワード変更時
      current_member.password = params[:member][:password]
      current_member.password_confirmation = params[:member][:password_confirmation]
    end

    if params[:member][:email] != current_member.email
      # Eメール変更時
      current_member.skip_reconfirmation!
      current_member.email = params[:member][:email]
    end

    if current_member.save
      flash[:success] = '更新が完了しました'
      sign_in(current_member, bypass: true)
      redirect_to member_path
    else
      flash.now[:error] = '入力内容をご確認ください'
      render :edit
    end
  end

  def destroy
    current_member.leave
    redirect_to left_member_path
  end

  def left
    @message = '退会処理が完了しました。ご利用ありがとうございました。'
    render '/message', layout: 'front'
  end

  private
  def post_params
    params.require(:member).permit(:account_name)
  end
end
