Rails.application.routes.draw do
  namespace :admin, path: 'admin' do
    root 'top#index'
  end

  root 'top#index'
end
