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
  @user = User.find(params[:id])
  if @user
    erb :'/users/show_user'
  else
    session[:errors] = "user not found"
    redirect '/'
  end
end

get '/users/:id/edit' do
  @user = User.find(params[:id])
  if @user && @user.id == session[:user_id]
    erb :'/users/edit_user'
  else
    session[:errors] = "You can't change another user"
    redirect '/'
  end
end

put '/users/:id' do
  @user = User.find(params[:id])
  if @user && @user.id == session[:user_id]
    @user.assign_attributes(password: params['password'])
    if @user.valid?
      @user.save
      session[:success] = "password changed successfully"
      redirect "/users/#{params[:id]}"
    else
      session[:errors] = @user.errors.full_messages[0]
      erb :'/users/edit_user'
    end
  else
    session[:errors] = "You can't change another user"
    redirect '/'
  end
end

delete '/users/:id' do
end
