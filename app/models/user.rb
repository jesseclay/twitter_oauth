class User < ActiveRecord::Base
  has_many :tweets
  validates_uniqueness_of :username

  def tweet(status, delay)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_async(tweet.id, delay)
  end

end
