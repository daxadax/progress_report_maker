Ganesh::Application.routes.draw do
    
  # root

  root                :to => 'pages#home'

  # static pages
                      
  match '/contact',   :to => 'pages#contact'
  match '/about',     :to => 'pages#about'
  match '/help',      :to => 'pages#help'
  
  # sessions
  
  resources :sessions, :only => [:new, :create, :destroy]
  
  match '/login',     :to => 'sessions#new'
  match '/logout',    :to => 'sessions#destroy'
  match '/farewell',  :to => 'pages#farewell'
                      
  # users
  
  resources :users# , except: [:show, :edit]
  match '/signup',    :to => 'users#new'
  # match '/home',      :to => 'users#show'
  # match '/settings',  :to => 'users#edit'
end