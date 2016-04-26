get '/posts/:post_id/votes' do
 if session[:user_id]
    post = Post.find(params[:post_id])
    new_vote = post.votes.new(user_id: session[:user_id])
    if new_vote.valid?
      new_vote.save
      redirect "/"
    else
      session[:errors] = new_vote.errors.full_messages[0]
      redirect "/"
    end
  else
    session[:errors] = "You need to login"
    redirect '/sessions/new'
  end
end

get '/comments/:comment_id/votes' do
 if session[:user_id]
    comment = Comment.find(params[:comment_id])
    new_vote = comment.votes.new(user_id: session[:user_id])
    if new_vote.valid?
      new_vote.save
      # if comment.post_id
      redirect "/"
    else
      session[:errors] = new_vote.errors.full_messages[0]
      redirect "/"
    end
  else
    session[:errors] = "You need to login"
    redirect '/sessions/new'
  end
end

