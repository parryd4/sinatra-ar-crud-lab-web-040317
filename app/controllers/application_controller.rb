require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "Hey"
  end

  get '/posts/new' do
    erb :new
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  post '/posts' do
    Post.create(params)
    @posts = Post.all
    redirect to('/posts')
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])

    erb :edit
  end

  patch '/posts/:id' do
    post = Post.find(params[:id])


    if post.update(name: params[:name], content: params[:content])
      redirect to("/posts/#{post.id}")
    else
      erb :show
    end

  end

  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @rip = @post.name
    @post.destroy
    erb :delete
  end

  get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :show
  end


end
