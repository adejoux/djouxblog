Djouxblog::Application.routes.draw do

  get '/versions/:id/edit', to: 'versions#edit', as: 'edit_version'

  get '/versions/:id', to: 'versions#show', as: 'version'

  post "versions/:id/revert" => "versions#revert", :as => "revert_version"

  get 'tags/:tag', to: 'posts#index', as: :tag
  resources :images

  resources :posts do
    collection do
      get :add_comment, to:'posts#add_comment'
    end
  end

  resources :comments

  authenticated :user do
    root :to => 'posts#index'
  end

  root :to => "posts#index"
  devise_for :users
  resources :users
end
