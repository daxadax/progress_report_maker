Ganesh::Application.routes.draw do
    
  # root

  root :to => 'pages#home'

  # associations 
  
  resources :student_groups do
    resources :students, :subjects
  end

  resources :subjects, :only => :stub do
    resources :goals
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
  
  match '/groups',   :to => 'student_groups#index'
  match '/group/:id', :to => 'student_groups#show', :as => :group  
  
  # students
  
  match ':student_group_id/student/:id', :to => 'students#show', :as => :student
  match 'students',                      :to => 'students#index'
  
  # subjects
  
  match ':student_group_id/subject/:id', :to => 'subjects#show', :as => :subject
  match 'subjects',                      :to => 'subjects#index'
    
  # goals
  
  match ':subject_id/goal/:id', :to => 'goals#show', :as => :goal
  match 'goals', :to => 'goals#index'
    
end