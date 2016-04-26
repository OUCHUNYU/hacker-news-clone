get '/' do
  @posts = Post.all
  erb :'/posts/index_post'
end

get '/posts/new' do
  erb :'/posts/new_post'
end

post '/posts' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    new_post = @user.posts.new(title: params['posts']['title'], url: params['posts']['url'], content: params['posts']['content'])
    if new_post.valid?
      new_post.save
      redirect '/'
    else
      session[:errors] = new_post.errors.full_messages[0]
      erb :'/posts/new_post'
    end
  else
    session[:errors] = "You need to login"
    redirect '/sessions/new'
  end
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :'/posts/show_post'
end

get '/posts/:id/edit' do
  user = User.find(session[:user_id])
  @post = user.posts.find_by(id: params[:id])
  if @post
    erb :'/posts/edit_post'
  else
    session[:errors] = "Post not found"
    redirect '/'
  end
end

put '/posts/:id' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    target_post = @user.posts.find(params[:id])
    if target_post
      target_post.update_attributes(title: params['posts']['title'], url: params['posts']['url'], content: params['posts']['content'])
      redirect "/posts/#{params[:id]}"
    else
      session[:errors] = "Post not found"
      redirect '/'
    end
  else
    session[:errors] = "You need to login"
    redirect '/sessions/new'
  end
end

get '/posts/:id/delete' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    target_post = @user.posts.find(params[:id])
    if target_post
      target_post.destroy
      redirect "/"
    else
      session[:errors] = "Post not found"
      redirect '/'
    end
  else
    session[:errors] = "You need to login"
    redirect '/sessions/new'
  end
end

