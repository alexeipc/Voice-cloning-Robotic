Rails.application.routes.draw do
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  get '/login' => 'users#login'
  get '/register' => 'users#register'
  #post '/sessions' => 'sessions#create'
  post '/users' => 'users#create'
  get '/dashboard' => 'dashboard#index'

  # root "articles#index"
end
