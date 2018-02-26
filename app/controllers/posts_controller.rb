class PostsController < ApplicationController

  helper_method :params

  def index
    @posts = Post.all
    @authors = Author.all

    # logic behind filter - filter @posts list based on user input(s)
    # posts_controller is concerned with the Post model, so almost everything that controller does will probably flow through that model
    # methods called below are in Post model 

    if !params[:author].blank?
      @posts = Post.by_author(params[:author])
    elsif !params[:date].blank?
      if params[:date] == "Today"
        @posts = Post.from_today
      else
        @posts = Post.old_news
      end
    else
      # if no filters are applied, show all posts
      @post = Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end
end
