Djouxblog::Application.routes.draw do

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
