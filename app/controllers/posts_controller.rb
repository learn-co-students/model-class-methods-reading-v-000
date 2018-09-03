class PostsController < ApplicationController

  def index
    @authors = Author.all
    if !params[:author].blank?
    @posts = Post.by_author(params[:author])
    elsif !params[:date].blank?
      if params[:date] == "Today"
      @posts = Post.where("created_at >=?", Time.zone.today.beginning_of_day)
      else
      @posts = Post.where("created_at <?", Time.zone.today.beginning_of_day)
     end
    else
      @posts = Post.all
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
