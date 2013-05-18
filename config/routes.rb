Ganesh::Application.routes.draw do
    
  # root

  root                :to => 'pages#home'

  # static pages
                        
  match '/about',         :to => 'pages#about'
  match '/confirmation',  :to => 'pages#confirmation'
  match '/contact',       :to => 'pages#contact'
  match '/error',         :to => 'pages#error'
  match '/farewell',      :to => 'pages#farewell'
  match '/finalfarewell', :to => 'pages#final_farewell'
  match '/help',          :to => 'pages#help'
  
  # sessions
  
  resources :sessions, :only => [:new, :create, :destroy]
  
  match '/login',     :to => 'sessions#new'
  match '/logout',    :to => 'sessions#destroy'
                      
  # users
  
  resources :users# , except: [:show, :edit]
  match '/signup',    :to => 'users#new'
  # match '/home',      :to => 'users#show'
  # match '/settings',  :to => 'users#edit'
end