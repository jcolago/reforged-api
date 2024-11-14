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
          patch "/players/:id/toggle_display", to: "players#toggle_display"
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
  end
end
