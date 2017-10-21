Rails.application.routes.draw do

  devise_for :members, controllers: {
      sessions:      'members/sessions',
      passwords:     'members/passwords',
      registrations: 'members/registrations',
      confirmations: 'members/confirmations',
      omniauth_callbacks: 'members/omniauth_callbacks'
  }

  devise_for :managers, controllers: {
      sessions:      'managers/sessions',
      passwords:     'managers/passwords',
      registrations: 'managers/registrations'
  }

  namespace :admin, path: 'admin' do
    resources :categories, except: :show
    resources :items, except: :show

    resources :images, only: [:new, :create]
    root 'dashboard#index', as: :root
  end

  root 'top#index'
end
