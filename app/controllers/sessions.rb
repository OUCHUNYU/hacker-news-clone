get '/sessions/new' do
  erb :'/sessions/new_session'
end

post '/sessions' do
  if User.authenticate(params['sessions']['email'], params['sessions']['password'])
    user = User.find_by(email: params['sessions']['email'])
    session[:success] = "Welcome back #{user.username}"
    session[:user_id] = user.id
    redirect '/'
  else
    session[:errors] = "email and password not match"
    redirect '/sessions/new'
  end
end

get '/sessions/logout' do
  session.clear
  session[:success] = "Logout successfully"
  redirect '/'
end
