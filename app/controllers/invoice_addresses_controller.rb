class InvoiceAddressesController < FrontBase
  before_action :authenticate_member!
  layout 'account'

  def show
    @address = current_member.addresses.find_or_initialize_by(invoice: true)
    if params[:purchase].present?
      render '/purchases/invoice_addresses/show', layout: 'purchase'
    end
  end

  def create
    @address = current_member.addresses.build(post_params)
    if @address.invoice_create
      if params[:purchase].present?
        redirect_to new_purchase_path
      else
        flash[:success] = '登録が完了しました'
        redirect_to member_invoice_address_path
      end
    else
      flash.now[:error] = '入力内容をご確認ください'
      if params[:purchase].present?
        render '/purchases/invoice_addresses/show', layout: 'purchase'
      else
        render :show
      end
    end
  end

  def update
    @address = current_member.invoice_address
    @address.assign_attributes(post_params)
    if @address.save
      if params[:purchase].present?
        redirect_to new_purchase_path
      else
        flash[:success] = '登録が完了しました'
        redirect_to member_invoice_address_path
      end
    else
      flash.now[:error] = '入力内容をご確認ください'
      if params[:purchase].present?
        render '/purchases/invoice_addresses/show', layout: 'purchase'
      else
        render :show
      end
    end
  end

  private
  def post_params
    params.require(:address).permit(:last_name, :first_name, :phone, :postal_code, :prefecture_id, :address1, :address2, :delivery)
  end

end
