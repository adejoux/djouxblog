Djouxblog::Application.routes.draw do



  get "infos/:id", to: 'infos#show', as: 'info'

  get "posts/index"
  get "posts/:id", to: 'posts#show', as: 'post'
  get "posts", to: 'posts#index', as: 'posts'

  get "wiki/index"
  get "wiki/:id", to: 'wiki#show', as: 'wiki'
  get "wiki", to: 'wiki#index', as: 'wikis'

  get '/versions/:id/edit', to: 'versions#edit', as: 'edit_version'
  get '/versions/:id', to: 'versions#show', as: 'version'
  post "versions/:id/revert" => "versions#revert", :as => "revert_version"

  get 'tags/:tag', to: 'posts#index', as: :tag

  resources :images

  resources :pages do
    collection do
      get :add_comment, to:'pages#add_comment'
    end
  end

  resources :comments

  root :to => "posts#index"
  devise_for :users
  resources :users
end
