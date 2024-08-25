Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: :index do
        member do
          get :export_order
        end
      end
    end
  end
  resources :posts

  mount ActionCable.server => '/cable'
end
