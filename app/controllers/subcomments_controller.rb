get '/post/:post_id/comments/:comment_id/subcomments/new' do
  if session[:user_id]
    @comment = Comment.find(params[:comment_id])
    if @comment
      @post_id = params[:post_id]
      erb :'/subcomments/new_subcomment'
    else
      session[:errors] = "comment not found"
      redirect "/posts/#{params[:post_id]}"
    end
  else
    session[:errors] = "You need to login"
    redirect '/sessions/new'
  end
end

post '/post/:post_id/comments/:comment_id/subcomments' do
  if session[:user_id]
    comment = Comment.find(params[:comment_id])
    new_subcomment = comment.subcomments.new(content: params['subcomments']['content'], user_id: session[:user_id])
    if new_subcomment.valid?
      new_subcomment.save
      redirect "/posts/#{params[:post_id]}"
    else
      session[:errors] = new_subcomment.errors.full_messages[0]
      redirect "/posts/#{params[:post_id]}"
    end
  else
    session[:errors] = "You need to login"
    redirect '/sessions/new'
  end
end

