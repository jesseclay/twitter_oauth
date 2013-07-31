get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  sign_out
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  # debugger
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  
  user = User.find_or_create_by_username_and_oauth_token_and_oauth_secret(username: @access_token.params[:screen_name], oauth_token: @access_token.token, oauth_secret: @access_token.secret)
  session[:id] = user.id
  # set_current_user(@access_token.token, @access_token.secret)
  erb :index
  
end

post '/tweet' do
  Twitter::Client.new(
      :oauth_token => current_user.oauth_token,
      :oauth_token_secret => current_user.oauth_secret).update(params[:tweet])
end 
