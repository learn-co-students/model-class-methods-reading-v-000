class PostsController < ApplicationController
  #added to ensure access to params hash
  helper_method :params
  #Note: You can use helper_method in a controller to expose, or make available, a controller method in your view, but, as we'll talk about soon, this isn't always a great idea.

  def index
    @posts = Post.all

    # provide a list of authors to the view for the filter control
    @authors = Author.all

    if !params[:author].blank?
      @posts = Post.by_author(params[:author])
            #So having something that looks like this...
        #@posts = Post.where(author: params[:author])
        #...isn't the best application of MVC and separation of concerns.
        #You'll notice that it's essentially the same code that we had in the controller, but it's now properly encapsulated in the model. This way, a controller doesn't have to query the database — it just has to ask for posts by_author.
      
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
=begin

#added to index.html.erb

<div>

<% if !params[:author].blank? %>
  <% @posts = Post.where(author: params[:author]) %>
<% end %>
<!-- new code ends here -->
 
<h1>Believe It Or Not I'm Blogging On Air</h1>

  <h3>Filter posts:</h3>
  <%= form_tag("/posts", method: "get") do %>
    <%= select_tag "author", options_from_collection_for_select(Author.all, "id", "name"), include_blank: true %>
    <%= submit_tag "Filter" %>
  <% end %>
</div> 
  
=end

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
