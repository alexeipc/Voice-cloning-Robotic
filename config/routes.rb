Rails.application.routes.draw do
  get 'reader/index'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'  
  delete '/logout' => 'sessions#destroy'
  
  get '/register' => 'users#register'
  post '/register' => 'users#create'

  get '/dashboard' => 'dashboard#index'
  get '/record' => 'dashboard#record'
  post '/record' => 'dashboard#submit_voice'
  delete '/record' => 'dashboard#delete_voice'

  post '/change_user_password' => 'dashboard#change_password'
  post '/change_user_infor' => 'dashboard#change_infor'

  get '/read/' => 'reader#default'
  get '/read/:story' => 'reader#index'
  post '/read/:story' => 'reader#synthesize'
  delete '/read/:story' => 'reader#delete'
  get '/read/:story/audio.wav' => 'reader#audio'
  # root "articles#index"
end
