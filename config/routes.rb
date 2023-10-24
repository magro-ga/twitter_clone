Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :tweets, except: [:create, :edit, :delete]
      resources :likes, except: [:create]

      root to: "tweets#index"

      post '/tweets/:id/comments', to: 'tweets#comments', as: :comments
    end
  end
end
