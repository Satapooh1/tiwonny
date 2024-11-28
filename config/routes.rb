Rails.application.routes.draw do
  get "profiles/show"
  get "profiles/edit"
  get "profiles/update"
  devise_for :users
  resource :profile, only: [ :show, :edit, :update ]

  resources :posts do
    resources :comments, only: :create
    resources :likes, only: [ :create, :destroy ]
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA files
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Root path
  root "posts#index"
end
