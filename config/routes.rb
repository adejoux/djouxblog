Djouxblog::Application.routes.draw do
  resources :articles


    namespace :mercury do
      resources :images
    end

  mount Mercury::Engine => '/'

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end