Djouxblog::Application.routes.draw do

  get '/versions/:id/edit', to: 'versions#edit', as: 'edit_version'

  get '/versions/:id', to: 'versions#show', as: 'version'

  post "versions/:id/revert" => "versions#revert", :as => "revert_version"

  resources :images

  resources :pages do
    collection do
      get :add_comment, to:'pages#add_comment'
    end
  end

  resources :comments

  authenticated :user do
    root :to => 'pages#index'
  end

  root :to => "pages#index"
  devise_for :users
  resources :users

  get ':category/:id', to: 'pages#show'
  get ':category', to: 'pages#index'
end
