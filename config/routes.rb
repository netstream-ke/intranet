Rails.application.routes.draw do

  root "sessions#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/dashboard", to: "dashboard#index"

  resources :tasks
  resources :users

end