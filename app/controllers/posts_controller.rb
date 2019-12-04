class PostsController < ApplicationController
  helper_method :params

  def index
    @posts = Post.all
    #this provides a list of authors to the view, for the filter control
    @authors = Author.all

    #filters @post list based on user input
    if !params[:author].blank?
      @posts = Post.by_author(params[:author])
    elsif !params[:date].blank? 
        if params [:date] == "Today"
          @post = Post.from_today
        else
          @post = Post.old_news
        end
      else 
        #if no posts are selected, show all of the posts
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
