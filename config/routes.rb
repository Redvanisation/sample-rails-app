Rails.application.routes.draw do
  
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'account_activations/edit'

  root 'static_pages#home'
  
  get  '/about',   to: 'static_pages#about'
  get  '/help',    to: 'static_pages#help'
  get  '/contact', to: 'static_pages#contact'
  get '/signup',   to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts,      only: [:create, :destory]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
