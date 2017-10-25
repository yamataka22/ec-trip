class DeliveryAddressesController < FrontBase
  before_action :authenticate_member!
  before_action :set_address, only: [:edit, :update, :destroy]
  layout 'account'

  def index
    @addresses = current_member.delivery_addresses
  end

  def new
    @address = Address.new
  end

  def create
    @address = current_member.addresses.build(post_params)
    @address.delivery = true
    respond_to do |format|
      if @address.save
        @addresses = current_member.delivery_addresses
        format.js
      else
        format.js {render :new}
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
