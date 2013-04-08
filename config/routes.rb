Ganesh::Application.routes.draw do
    
  # static pages
  
  root              :to => 'pages#home' 
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/help',    :to => 'pages#help'
  
  # users
  
  resources :users
  match '/signup', :to => 'users#new'
  
  # sessions
  
  resources :sessions, :only => [:new, :create, :destroy]
  match 'login',    :to => 'sessions#new'
  match 'logout',   :to => 'sessions#destroy'
  match 'farewell', :to => 'pages#farewell'
  
end
 
 # get "login" => "sessions#new", :as => "login"