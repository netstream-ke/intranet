Rails.application.routes.draw do
  # =========================
  # ROOT & AUTH
  # =========================
  root "sessions#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/games", to: "pages#games", as: :games

  # =========================
  # ADMIN
  # =========================
  get "/admin/dashboard", to: "admin#dashboard", as: :admin_dashboard
  get "/admin/logs", to: "admin#logs", as: :admin_logs

  # =========================
  # MAIN FEATURES
  # =========================
  resources :tasks do
    resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy]
  resources :users

  resources :news do
    member do
      patch :move
    end
  end

  # =========================
  # EXTRA FEATURES
  # =========================
  get "/board", to: "tasks#board"
  patch "/tasks/:id/update_status", to: "tasks#update_status"

  get "/reports", to: "reports#index"
  get "/notifications", to: "notifications#index"

  patch "/users/:id/toggle_suspend", to: "users#toggle_suspend", as: "toggle_suspend"
  patch "/users/:id/update_role", to: "users#update_role", as: "update_role"
  patch "/users/:id/update_password", to: "users#update_password", as: "update_password"
  get "/users/:id/edit_password", to: "users#edit_password", as: "edit_password"

  # Autocomplete
  get "users/autocomplete", to: "users#autocomplete"
  get "tasks/autocomplete", to: "tasks#autocomplete"

  # Typing indicators
  post "/typing", to: "comments#typing"
  post "/stop_typing", to: "comments#stop_typing"
end