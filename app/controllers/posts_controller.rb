class PostsController < ApplicationController


  def index
  # provide a list of authors to the view for the filter control
  @authors = Author.all

  # filter the @posts list based on user input
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
    @posts = Post.all
  end
end
end
