Rails.application.routes.draw do
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  get '/register' => 'users#register'
  post '/register' => 'users#create'

  get '/dashboard' => 'dashboard#index'


  post '/change_user_password' => 'dashboard#change_password'
  post '/change_user_infor' => 'dashboard#change_infor'

  # root "articles#index"
end
