get '/newest' do
  @posts = Post.order(:created_at)
  erb :'/posts/index_post'
end
