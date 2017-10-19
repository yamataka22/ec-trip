Rails.application.routes.draw do
  devise_for :members, controllers: {
      sessions:      'members/sessions',
      passwords:     'members/passwords',
      registrations: 'members/registrations',
      confirmations: 'members/confirmations',
      omniauth_callbacks: 'members/omniauth_callbacks'
  }

  namespace :admin, path: 'admin' do
    root 'top#index'
  end

  root 'top#index'
end
