Djouxblog::Application.routes.draw do

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
