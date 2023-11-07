class AddTweetRefenceToRetweets < ActiveRecord::Migration[7.1]
  def change
    add_column :tweets, :tweet_id, :integer
    add_foreign_key :tweets, :tweets
  end
end
