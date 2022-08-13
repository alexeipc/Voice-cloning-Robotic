Rails.application.routes.draw do
  get 'admin/login'
  get 'admin/submit'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  get '/register' => 'users#register'
  post '/register' => 'users#create'

  get '/admin' => 'admin#login'
  post '/admin' => 'admin#create'
  delete '/adminlogout' => 'sessions#destroy'

  get '/admin_dashboard' => 'admin_dashboard#index'

  get '/dashboard' => 'dashboard#index'
  get '/record' => 'dashboard#record'
  post '/record' => 'dashboard#submit_voice'
  delete '/record' => 'dashboard#delete_voice'

end
