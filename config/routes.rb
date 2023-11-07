Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  namespace :api do
    namespace :v1 do
      resources :tweets do
        resources :comments
        get 'comments', to: 'comments#index', on: :member, as: 'show_comments'
      end

      resources :topics do
        get 'tweets', on: :member
      end

      resources :tweets do
        get 'topic/:id', action: :show_topic_posts, on: :collection, as: :topic_posts
      end

      resources :users, only: [:show, :index]

      resources :comments
      root to: "tweet#index"
      post '/tweets/:id/retweets', to: 'tweets#retweet', as: :retweets
      post '/tweets/:id/quote_tweets', to: 'tweets#quote_tweet', as: :quote_tweets
      post '/tweets/:id/replies', to: 'tweets#reply_tweet', as: :replies
    end
  end
end
