Rails.application.routes.draw do
  root "application#index"

  scope 'api/v1' do
    use_doorkeeper do
      controllers :tokens => 'api/v1/custom_tokens'
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy] do
        namespace :links do
        end
      end
      resources :teams, only: [:index, :create, :show, :update, :destroy]
      resources :password_recoveries,   only: [:create]
      resources :password_resets,       only: [:create]
      resources :sessions, only: [:create]
    end
  end
end
