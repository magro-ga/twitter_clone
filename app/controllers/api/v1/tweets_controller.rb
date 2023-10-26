class Api::V1::TweetsController < ApplicationController
    def index
      render json:Tweet.all
    end

    def create
      @tweet = Tweet.new(tweet_params)

      render json: tweet
    end

    def show
      begin
        @tweet = Tweet.find([:id])
        render render_args(tweet)
      rescue StandardError => e
        render json: {
          error: e.message
        },
        status: :bad_request
      end
    end

    def destroy
      begin
        @tweet = Tweet.find(params[:id]).destroy
        render render_args(tweet)
      rescue StandardError => e
        render json: {
          error: e.message
        },
        status: :bad_request
      end
    end

    def retweet
      @retweet = @tweet.retweets.create!(tweet_params)
      json_response(@retweet, :created)
    rescue ActiveRecord::RecordInvalid => e
      json_response({ message: e.message }, :unprocessable_entity)
    end

    def quote_tweet
      @retweet = @tweet.quote_tweets.create!(tweet_params)
      json_response(@retweet, :created)
    rescue ActiveRecord::RecordInvalid => e
      json_response({ message: e.message }, :unprocessable_entity)
    end

    def reply_tweet
      @retweet = @tweet.replies.create!(tweet_params)
      json_response(@retweet, :created)
    rescue ActiveRecord::RecordInvalid => e
      json_response({ message: e.message }, :unprocessable_entity)
    end

    private

    def set_tweet
      @tweet = Tweet.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      json_response({ message: 'Tweet not found' }, :not_found)
    end

    def tweet_params
      params.require(:tweet).permit(:body)
    end
end
