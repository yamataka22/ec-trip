class DeliveryAddressesController < FrontBase
  before_action :authenticate_member!
  before_action :set_address, only: [:edit, :update, :destroy]
  layout 'account'

  def index
    if current_member.delivery_addresses.blank?
      redirect_to new_member_delivery_address_path(purchase: params[:purchase]) and return
    end
    @addresses = current_member.delivery_addresses
    render '/purchases/delivery_addresses/index', layout: 'purchase' if params[:purchase].present?
  end

  def new
    @address = Address.new
    render '/purchases/delivery_addresses/new', layout: 'purchase' if params[:purchase].present?
  end

  def create
    @address = current_member.addresses.build(post_params)
    @address.delivery = true
    save_success = @address.save
    if params[:purchase].present?
      if save_success
        respond_to do |format|
          format.js {render '/purchases/delivery_addresses/create' }
          format.html {redirect_to new_purchase_path(delivery_address_id: @address.id)}
        end
      else
        respond_to do |format|
          format.js {render '/purchases/delivery_addresses/new' }
          format.html {render '/purchases/delivery_addresses/new', layout: 'purchase' }
        end
      end
    else
      if save_success
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
