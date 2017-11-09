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

  resources :carts, only: [:index, :create, :update, :destroy]
  namespace :order, path: 'order' do
    resources :purchases, only: [:new, :create] do
      member { get :complete }
    end
    resource :invoice_address, only: [:show, :create, :update]
    resources :delivery_addresses, only: [:index, :new, :create]
    resources :credit_cards, only: [:index, :new, :create]
    resources :guests, only: [:new, :create] do
      collection do
        get :sign_in
        post :confirm
      end
    end
  end

  resource :member, only: [:show, :update, :destroy] do
    collection do
      get :leave
      get :left
    end
  end
  namespace :member, path: 'member' do
    resources :favorites, only: [:index, :create, :destroy]
    resource :invoice_address, only: [:show, :create, :update]
    resources :delivery_addresses do
      member {post :change_main}
    end
    resources :credit_cards, only: [:index, :new, :create, :destroy] do
      member {post :change_main}
    end
    resources :purchases, only: [:index, :show]
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
    root 'top#index', as: :root
  end

  get 'static_pages/:name' => 'static_pages#show', as: :static_page

  # 郵便番号検索
  get 'postal_codes/:code' => 'postal_codes#show'
  post '/tinymce_assets' => 'admin/images#create'
  root 'top#index'
  get '*anything' => 'errors#routing_error'
end
