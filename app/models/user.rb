class User < ActiveRecord::Base
  has_many :tweets
  validates_uniqueness_of :username

  def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_async(tweet.id)
  end

end
