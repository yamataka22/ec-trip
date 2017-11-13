class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]
  after_action :clear_flash, only:[:facebook, :twitter]

  def facebook
    @member = Member.from_omniauth(request.env['omniauth.auth'])
    callback('Facebook')
  end

  def twitter
    @member = Member.from_omniauth(request.env['omniauth.auth'])
    callback('Twitter')
  end

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  private
  def callback(kind)
    if @member.present?
      sign_in_and_redirect @member, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => kind) if is_navigational_format?
    else
      session['omniauth'] = {
          'info': request.env['omniauth.auth']['info'],
          'provider': request.env['omniauth.auth']['provider'],
          'uid': request.env['omniauth.auth']['uid']
      }
      redirect_to new_member_registration_url
    end
  end

  def clear_flash
    flash.delete(:notice) if flash[:notice].present?
    flash.delete(:success) if flash[:success].present?
  end
end
