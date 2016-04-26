get '/users' do
  @users = User.all
  erb '/users/index_user'
end

post '/users' do
  new_user = User.new(username: params['users']['username'], email: params['users']['email'], password: params['users']['password'])
  if new_user.valid?
    new_user.save
    session[:success] = "New user reated successfully"
    session[:user_id] = new_user.id
    redirect '/'
  else
    session[:errors] = new_user.errors.full_messages[0]
    erb :'/users/new_user'
  end
end

get '/users/:id' do
end

get '/users/:id/edit' do
end

put '/users/:id' do
end

delete '/users/:id' do
end
