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
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

 end