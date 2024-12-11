Rails.application.routes.draw do
  namespace :admin do
    get "dashboard/index"
  end
  root "books#index"
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  get "search/index"
  resources :order_items
  resources :orders
  resources :authors
  resources :books
  resources :provinces
  resources :users
  resources :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :genres, only: [ :show ] do
    get "books", to: "books#by_genre", on: :member
  end
  get "search", to: "search#index", as: "search"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"  # Handle logout

  get "signup", to: "users#new"
  post "signup", to: "users#create"

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    resources :books
    resources :genres
    resources :authors
    get "edit_pages", to: "dashboard#edit_pages"
    patch "update_pages", to: "dashboard#update_pages"
  end

  resources :orders, only: [ :new, :create, :show ]
  resources :books, only: [ :index, :show ]
  post "add_to_cart", to: "carts#add_to_cart", as: "add_to_cart"
  get "cart", to: "carts#show", as: "cart"
  get "remove_from_cart/:book_id", to: "carts#remove_from_cart", as: "remove_from_cart"
  patch "update_quantity/:book_id", to: "carts#update_quantity", as: "update_quantity"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
