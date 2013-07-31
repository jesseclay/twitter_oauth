helpers do

  # def set_current_user(token, secret)
  #   @current_user = "yay"
  #   # @current_user = Twitter::Client.new(
  #   #   :oauth_token => token,
  #   #   :oauth_token_secret => secret)
  #   # p "CURRENT USER FROM SET"
  #   # p @current_user
  #   session
  # end

  def current_user
    User.find(session[:id])
  end

  # def sign_out
  #   @current_user = nil
  # end

end
