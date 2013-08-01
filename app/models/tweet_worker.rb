class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    p "IN TWEETWORKER"
    tweet = Tweet.find(tweet_id)
    p "TWEET: #{tweet}"
    user  = tweet.user
    p "USEROAUTH: #{user.oauth_token}"
    p "USEROAUTH: #{user.oauth_secret}"
    p "TWEETSTATUS: #{tweet.status}"


    client = Twitter::Client.new(
      consumer_key: ENV['TWITTER_KEY'],
      consumer_secret: ENV['TWITTER_SECRET'],
      :oauth_token => user.oauth_token,
      :oauth_token_secret => user.oauth_secret)

    p "TWITTER_CLIENT: #{client.inspect}"
    p tweet.status
    client.update(tweet.status)


  end
end
