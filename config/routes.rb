Rails.application.routes.draw do
  use_doorkeeper

  root "application#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy] do
        namespace :links do
        end
      end
      resources :sessions, only: [:create]
    end
  end
end
