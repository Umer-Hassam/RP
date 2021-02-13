Rails.application.routes.draw do
  resources :work_durations
  resources :employees
  devise_for :users
  resources :vendors
  resources :user_types
  resources :job_applications
  resources :job_posts
  resources :profiles
  resources :employees
  resources :work_durations
  resources :projects
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'profiles#show'

  # Rails.application.routes.draw do
  
  
#       devise_for :users, controllers: {
#         sessions: 'users/sessions'
#       }
#     end
end


