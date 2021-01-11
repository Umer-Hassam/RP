Rails.application.routes.draw do
  devise_for :users
  resources :vendors
  resources :user_types
  resources :job_applications
  resources :job_posts
  resources :profiles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'job_posts#index'
end
