class PostsController < ApplicationController

  def index
    @posts = Post.on_index.published.order('published_at desc')
  end

  def show
    @post = Post.friendly.find(params[:id])
  end

end
