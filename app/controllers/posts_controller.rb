class PostsController < ApplicationController

  def index
    @posts = Post.all
    @authors = Author.all

    if filter_author_requested?
      @posts = Post.by_author(params[:author])
    end

    if filter_date_requested?
      @posts = Post.send(params[:date].downcase.gsub(" ", "_"))
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end

  private
    def post_params
      params.require(:post).permit(:title, :description)
    end

    def filter_author_requested?
      params[:author].present?
    end

    def filter_date_requested?
      params[:date].present?
    end

end
