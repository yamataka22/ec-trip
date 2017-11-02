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

  resources :items, only: [:index, :show]
  resources :purchases, only: [:new, :create] do
    collection { get :complete }
  end

  resource :member, only: [:show, :update, :destroy] do
    resources :carts, only: [:index, :create, :update, :destroy]
    resources :favorites, only: [:index, :create, :destroy]
    resource :invoice_address, only: [:show, :create, :update]
    resources :delivery_addresses
    resources :credit_cards, only: [:index, :new, :create, :destroy]
    resources :purchases, only: [:index, :show]
    collection do
      get :leave
      get :left
    end
  end

  resource :contacts, only: [:new, :create] do
    collection do
      post :confirm
      get :complete
    end
  end

  devise_for :managers, path: 'admin/manager', controllers: {
      sessions:      'admin/managers/sessions'
  }
  namespace :admin, path: 'admin' do
    resources :categories, except: :show
    resources :items, except: :show do
      collection { get :preview }
    end
    resources :purchases, only: [:index, :show, :update]
    resources :topics, except: :show
    resources :sliders, only: [:index, :edit, :update]
    resources :static_pages do
      collection { get :preview }
    end
    resources :contacts, only: [:index, :show, :destroy]
    resources :members, only: [:index, :show, :destroy]
    resources :managers, except: [:show]

    resources :images, only: [:new, :create]
    root 'dashboard#index', as: :root
  end

  get 'static_pages/:name' => 'static_pages#show', as: :static_page

  post '/tinymce_assets' => 'admin/images#create_tinymce'
  root 'top#index'
end
