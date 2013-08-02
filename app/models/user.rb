class User < ActiveRecord::Base
  has_many :tweets
  validates_uniqueness_of :username

  def tweet(status, delay)
    tweet = tweets.create!(:status => status)
    # p "right before 2 min perform"
    # TweetWorker.perform_in(2.minutes, tweet.id, delay)
    # p "right after 2 min perform"
    TweetWorker.perform_async(tweet.id, delay)
  end

end
