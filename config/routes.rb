Ganesh::Application.routes.draw do
    
  # root

  root :to => 'pages#home'

  # associations 
  
  resources :student_groups do
    resources :students
  end

  # static pages
                        
  match '/about',         :to => 'pages#about'
  match '/confirmation',  :to => 'pages#confirmation'
  match '/contact',       :to => 'pages#contact'
  match '/error',         :to => 'pages#error'
  match '/farewell',      :to => 'pages#farewell'
  match '/finalfarewell', :to => 'pages#final_farewell'
  match '/help',          :to => 'pages#help'
  match '/settings',      :to => 'pages#settings'
  
  # sessions
  
  resources :sessions, :only => [:new, :create, :destroy]
  
  match '/login',  :to => 'sessions#new'
  match '/logout', :to => 'sessions#destroy'
                      
  # users
  resources :users
  
  match '/signup', :to => 'users#new'
  # match '/home',      :to => 'users#show'
  # match '/settings',  :to => 'users#edit'
  
  # student_groups
  
  match '/classes',   :to => 'student_groups#index'
  match '/class/:id', :to => 'student_groups#show', :as => :class  
  
  # students
  
  match ':student_group_id/student/:id', :to => 'students#show', :as => :student  
end