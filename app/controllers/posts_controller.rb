get '/' do
  @posts = Post.all
  erb :'/posts/index_post'
end

get '/posts/new' do
  erb :'/posts/new_post'
end

post '/posts' do
  new_post = Post.new(title: params['posts']['title'], url: params['posts']['url'], text: params['posts']['text'])
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  erb :'/posts/show_post'
end

get '/posts/:id/edit' do
end

put '/posts/:id' do
end

delete '/posts/:id' do
end
