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

    private

    def tweet_params
      params.require(:tweet).permit(:body)
    end
end
