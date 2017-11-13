class Members::RegistrationsController < Devise::RegistrationsController
  layout 'front'
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new
    super do
      if session['omniauth']
        resource.email = session['omniauth']['info']['email']
        resource.account_name = session['omniauth']['info']['name']
      end
    end
  end

  def create
    super do
      if session['omniauth'].present?
        resource.provider = session['omniauth']['provider']
        resource.uid = session['omniauth']['uid']
      else
        # 通常SignUpでも任意の値をuidに設定しておく
        resource.uid = SecureRandom.uuid
      end
      if resource.save
        session['omniauth'] = nil
      end
    end
  end

  # GET /resource/edit
  def edit
    redirect_to member_path
  end

  # PUT /resource
  def update
    redirect_to member_path
  end

  def select
    session['omniauth'] = nil
  end

  def inactive
    @title = 'ご登録ありがとうござます。'
    @message = 'ご指定のメールアドレスにメールをお送りいたしました。<br>メール本文のリンクをクリックして登録を完了してください。'
    render '/message'
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:account_name])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:account_name])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    members_sign_up_inactive_path
  end

end
