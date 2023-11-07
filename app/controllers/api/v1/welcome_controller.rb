class Api::V1::WelcomeController < ApplicationController
	def index
		@tweets = Tweet.order(created_at: :desc).all
		@topics = Topic.all
		@random_users = User.all.sample(5)
		@topics_with_posts = Topic.joins(:tweets).distinct
	end
end
