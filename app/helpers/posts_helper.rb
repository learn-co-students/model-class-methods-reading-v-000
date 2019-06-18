module PostsHelper
  def filter_is_active?
    params[:commit] == "Filter"
  end
end