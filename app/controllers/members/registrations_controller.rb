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

        # プロフィール画像画像
        case resource.provider
          when 'facebook' then
            save_facebook_image
          when 'twitter' then
            save_twitter_image
        end
      else
        # 通常SignUpでも任意の値をuidに設定しておく
        resource.uid = SecureRandom.uuid
      end

      resource.save
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
    session['omniauth_data'] = nil
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

  private
  def save_facebook_image
    begin
      client = HTTPClient.new
      facebook_image_url = client.get("#{session['omniauth']['info']['image']}?type=large").header[:Location][0]
      profile_image = Image.create(image: open(facebook_image_url))
      resource.profile_image_id = profile_image.id
    rescue => e
      Rails.logger.error "Facebook画像保存失敗 uid: #{resource.uid} message: #{e.message}"
    end
  end

  def save_twitter_image
    begin
      profile_image = Image.create(image: open(session['omniauth']['info']['image'].gsub('_normal', '')))
      resource.profile_image_id = profile_image.id
    rescue => e
      Rails.logger.error "Twitter画像保存失敗 uid: #{resource.uid} message: #{e.message}"
    end
  end

end
