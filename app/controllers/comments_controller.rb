get '/comments' do
  @comments = Comment.all
  erb :'/comments/index_comment'
end

# get '/posts/:post_id/comments/new' do

# end

post '/posts/:post_id/comments' do
  if session[:user_id]
    post = Post.find(params[:post_id])
    new_comment = post.comments.new(content: params['comments']['content'], user_id: session[:user_id])
    if new_comment.valid?
      new_comment.save
      redirect "/posts/#{params[:post_id]}"
    else
      session[:errors] = new_comment.errors.full_messages[0]
      redirect "/posts/#{params[:post_id]}"
    end
  else
    session[:errors] = "You need to login"
    redirect '/sessions/new'
  end
end

# get '/posts/:id/comments/:id' do
# end

get '/posts/:post_id/comments/:id/edit' do
  if session[:user_id]
    user = User.find(session[:user_id])
    target_comment = user.comments.find(params[:id])
    if target_comment
      @post_id = params[:post_id]
      @comment_id = params[:id]
      erb :'/comments/edit_comment'
    else
      session[:errors] = "You can't edit other users comment"
      redirect "/"
    end
  else
    session[:errors] = "You need to login"
    redirect '/sessions/new'
  end
end

put '/posts/:post_id/comments/:id' do
  if session[:user_id]
    user = User.find(session[:user_id])
    target_comment = user.comments.find(params[:id])
    if target_comment
      target_comment.update_attributes(content: params['comments']['content'])
      redirect "/posts/#{params[:post_id]}"
    else
      session[:errors] = "You can't edit other users comment"
      redirect "/"
    end
  else
    session[:errors] = "You need to login"
    redirect '/sessions/new'
  end
end

get '/posts/:post_id/comments/:id/delete' do
  if session[:user_id]
    user = User.find(session[:user_id])
    target_comment = user.comments.find(params[:id])
    if target_comment
      target_comment.destroy
      redirect "/posts/#{params[:post_id]}"
    else
      session[:errors] = "You can't delete other users comment"
      redirect "/"
    end
  else
    session[:errors] = "You need to login"
    redirect '/sessions/new'
  end
end
