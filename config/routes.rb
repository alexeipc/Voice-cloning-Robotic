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
  get '/record' => 'dashboard#record'
  post '/record' => 'dashboard#submit_voice'
  delete '/record' => 'dashboard#delete_voice'

<<<<<<< Updated upstream
=======

  post '/change_user_password' => 'dashboard#change_password'
  post '/change_user_infor' => 'dashboard#change_infor'

  post '/submit_story' => 'stories#submit'
  get '/stories' => 'stories#index'
  post '/change_stories'=> 'stories#change'

>>>>>>> Stashed changes
  # root "articles#index"
end
