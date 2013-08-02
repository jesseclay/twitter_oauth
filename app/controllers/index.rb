get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
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
  p "***********************************************"
  p user.id
  p session[:id]
  erb :index
  
end

post '/tweet' do
  p session
  user = User.find(session[:id])
  if params[:delay]
    p "delayed tweet"
    user.tweet(params[:tweet],params[:delay])
  else
    user.tweet(params[:tweet],0)
  end
end 

get '/status/:job_id' do
  content_type :json
  job_is_complete(params[:job_id]).to_json
end
