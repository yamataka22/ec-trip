class Member::DeliveryAddressesController < FrontBase
  before_action :authenticate_member!
  before_action :set_address, only: [:edit, :update, :destroy]
  layout 'account'

  def index
    if current_member.delivery_addresses.blank?
      redirect_to new_member_delivery_address_path(purchase: params[:purchase]) and return
    end
    @addresses = current_member.delivery_addresses
  end

  def new
    @address = Address.new
  end

  def create
    @address = current_member.addresses.build(post_params)
    @address.delivery = true
    if @address.save
      respond_to do |format|
        format.js {@addresses = current_member.delivery_addresses}
        format.html do
          flash[:success] = '登録が完了しました'
          redirect_to member_delivery_addresses_path
        end
      end
    else
      respond_to do |format|
        format.js {render :new}
        format.html {render :new}
      end
    end
  end

  def edit
  end

  def update
    @address.assign_attributes(post_params)
    respond_to do |format|
      if @address.save
        @addresses = current_member.delivery_addresses
        format.js
      else
        format.js {render :edit}
      end
    end
  end

  def change_main
    current_member.main_address_id = params[:id]
    current_member.save
    flash[:success] = '規定の住所を変更しました'
    redirect_to member_delivery_addresses_path
  end

  def destroy
    @address.destroy
    flash[:success] = '削除が完了しました'
    redirect_to member_delivery_addresses_path
  end

  private
  def set_address
    @address = current_member.addresses.find(params[:id])
  end
  def post_params
    params.require(:address).permit(:last_name, :first_name, :phone, :postal_code, :prefecture_id, :address1, :address2)
  end
end
