class ContactsController < FrontBase
  def new
    @contact = Contact.new
    @contact.email = current_member.email if member_signed_in?
  end

  def confirm
    @contact = Contact.new(post_params)
    if @contact.valid?
      render :confirm
    else
      flash.now[:error] = '入力内容をご確認ください'
      render :new
    end
  end

  def create
    @contact = Contact.new(post_params)
    if params[:page_back].present?
      render :new
    else
      if @contact.save
        ContactReceivedJob.perform_later(@contact)
        redirect_to complete_contacts_path
      else
        flash.now[:error] = '入力内容をご確認ください'
        render :new
      end
    end
  end

  def complete
    @title = 'お問い合わせありがとうございました。'
    @message = '折り返し担当者よりご連絡いたしますので、 恐れ入りますがしばらくお待ちください。'
    render '/message'
  end

  private
  def post_params
    params.require(:contact).permit(:email, :phone, :first_name, :last_name, :body)
  end
end
