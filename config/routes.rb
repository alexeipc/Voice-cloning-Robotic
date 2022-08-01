Rails.application.routes.draw do
  namespace :admin do
    resources :dashboard
  end

  resources :dashboards, only: [:index, :show]
  
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  get '/register' => 'users#register'
  post '/register' => 'users#create'

  get '/dashboard' => 'dashboard#index'

  # root "articles#index"
end
