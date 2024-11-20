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
          patch :toggle_display
          patch :update_hp
        end
      end
      resources :monsters do
        member do
          patch :toggle_display
        end
        collection do
          get :monsters
          post :add_monster
          delete :remove_monster
        end
      end
      resources :games
      resources :users
    end
  end
end
