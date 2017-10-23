class Members::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    # StripeCustomerを登録しておく
    member = Member.where(confirmation_token: params[:confirmation_token]).first
    if member && member.stripe_customer_id.nil?
      stripe_customer = Stripe::Customer.create(
          description: "member_id: #{member.id}",
          email: member.email
      )
      member.stripe_customer_id = stripe_customer.id
      member.save
    end

    super
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
