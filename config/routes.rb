Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'userlist', to: 'users#userlist'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :destroy, :update, :editd]do
    member do
      get :followings
      get :followers
      get :likes
    end
    collection do
      get :search
    end
  end
  post '/books/:id/edit', to: 'users#edit'
  resources :books
  resources :relationships, only: [:create, :destroy]
   resources :favorites, only: [:create, :destory]
  delete 'favorites', to: 'favorites#destroy'
end
