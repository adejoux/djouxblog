Djouxblog::Application.routes.draw do
  


  mount Mercury::Engine => '/'
 
  namespace :mercury do
    resources :images
  end

  resources :articles do
    member { post :mercury_update }
  end

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"
  devise_for :users
  resources :users
end