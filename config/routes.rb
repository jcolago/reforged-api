Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post :login, to: "sessions#login"
      get :me, to: "sessions#me"
      delete :logout, to: "sessions#logout"
      resources :player_conditions
      resources :conditions
      resources :players do
        member do
          patch "update_hp"
        end
      end
      resources :monsters do
        collection do
          get "monsters"
          post "add_monster"
          delete "remove_monster"
        end
      end
      resources :games
      resources :users
      end

      # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

      # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
      # Can be used by load balancers and uptime monitors to verify that the app is live.
      get "up" => "rails/health#show", as: :rails_health_check

      # Render dynamic PWA files from app/views/pwa/*
      get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
      get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

      # Defines the root path route ("/")
      root "pages#home"
      post "login", to: "users#login"
    end
  end
