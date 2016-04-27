get '/newest' do
  @posts = Post.order(created_at: :desc)
  erb :'/posts/index_post'
end

get '/popular' do
  @posts = Post.joins(:votes).group("posts.id").order("count(posts.id) DESC")
  erb :'/posts/index_post'
end
