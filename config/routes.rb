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
  # USERS
  # =========================
  resources :users do
    member do
      post :follow
      delete :unfollow
      patch :toggle_suspend
      patch :update_role
      patch :update_password
      get :edit_password
    end

    collection do
      get :autocomplete
    end
  end

  resources :notices

  # =========================
  # NEWS
  # =========================
  resources :news do
    collection do
      patch :sort
      get :editor
    end

    member do
      patch :move
    end
  end

  get "/mission", to: "pages#mission", as: :mission
  get "/vision", to: "pages#vision", as: :vision
  get "/values", to: "pages#values", as: :values

  # =========================
  # TASKS
  # =========================
  resources :tasks do
    resources :comments, only: [ :create ]
  end

  resources :conversations do
  resources :messages, only: [ :create ]
end

resources :chat_rooms do
  collection do
    get :new_chat   # user selection page
  end

  resources :chat_messages, only: [ :create ]
end

  resources :comments, only: [ :destroy ]

  # =========================
  # EXTRA FEATURES
  # =========================
  get "/board", to: "tasks#board"
  patch "/tasks/:id/update_status", to: "tasks#update_status"

  get "/reports", to: "reports#index"
  get "/notifications", to: "notifications#index"
  delete "/logout", to: "sessions#destroy"

  # =========================
  # TYPING INDICATORS
  # =========================
  post "/typing", to: "comments#typing"
  post "/stop_typing", to: "comments#stop_typing"
end
