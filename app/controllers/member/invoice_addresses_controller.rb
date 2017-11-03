class Member::InvoiceAddressesController < FrontBase
  before_action :authenticate_member!
  layout 'account'

  def show
    @address = current_member.addresses.find_or_initialize_by(invoice: true)
  end

  def create
    @address = current_member.addresses.build(post_params)
    if @address.invoice_create
      flash[:success] = '登録が完了しました'
      redirect_to member_invoice_address_path
    else
      flash.now[:error] = '入力内容をご確認ください'
      render :show
    end
  end

  def update
    @address = current_member.invoice_address
    @address.assign_attributes(post_params)
    if @address.save
      flash[:success] = '登録が完了しました'
      redirect_to member_invoice_address_path
    else
      flash.now[:error] = '入力内容をご確認ください'
      render :show
    end
  end

  private
  def post_params
    params.require(:address).permit(:last_name, :first_name, :phone, :postal_code, :prefecture_id, :address1, :address2, :delivery)
  end

end
