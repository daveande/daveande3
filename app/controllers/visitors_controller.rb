class VisitorsController < ApplicationController

  def index
    @posts = Post.on_index.published.order('published_at desc')
  end

end
