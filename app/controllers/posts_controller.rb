class PostsController < ApplicationController

  def index
    @authors = Author.all
    @posts = params[:author].blank? ? Post.all.includes(:author) : Post.by_author_including(params[:author])
    case params[:date]
    when "Today"
      @posts = @posts.select{|p| p.created_at >= today_start}
    when "Old News"
      @posts = @posts.select{|p| p.created_at < today_start}
    else
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
