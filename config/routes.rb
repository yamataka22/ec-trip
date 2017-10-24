Rails.application.routes.draw do

  devise_for :members, controllers: {
      sessions:      'members/sessions',
      passwords:     'members/passwords',
      registrations: 'members/registrations',
      confirmations: 'members/confirmations',
      omniauth_callbacks: 'members/omniauth_callbacks'
  }
  devise_scope :member do
    get '/members/sign_up/select', to: 'members/registrations#select'
    get '/members/sign_up/inactive', to: 'members/registrations#inactive'
    get '/members/signed_out', to: 'members/sessions#signed_out'
  end

  devise_for :managers, controllers: {
      sessions:      'managers/sessions',
      passwords:     'managers/passwords',
      registrations: 'managers/registrations'
  }

  resources :items, only: [:index, :show]
  resources :favorites, only: [:index, :create, :destroy]
  resources :carts, only: [:index, :create, :update, :destroy]

  namespace :admin, path: 'admin' do
    resources :categories, except: :show
    resources :items, except: :show

    resources :images, only: [:new, :create]
    root 'dashboard#index', as: :root
  end

  post '/tinymce_assets' => 'admin/images#create_tinymce'
  root 'top#index'
end
