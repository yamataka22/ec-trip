class Order::DeliveryAddressesController < FrontBase
  before_action :authenticate_member!
  before_action :set_address, only: [:edit, :update, :destroy]
  layout 'order'

  def index
    if current_member.delivery_addresses.blank?
      redirect_to new_order_delivery_address_path and return
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
        format.js {render :create }
        format.html {redirect_to new_order_purchase_path(delivery_address_id: @address.id)}
      end
    else
      respond_to do |format|
        format.js {render :new }
        format.html {render :new }
      end
    end

  end

  private
  def set_address
    @address = current_member.addresses.find(params[:id])
  end
  def post_params
    params.require(:address).permit(:last_name, :first_name, :phone, :postal_code, :prefecture_id, :address1, :address2)
  end
end
