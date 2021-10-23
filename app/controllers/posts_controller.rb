class PostsController < ApplicationController

  def index
    @posts = Post.on_index
      .published
      .order('published_at desc')
      .preload(:tags)
    @tag = params[:tag]
    @posts = @posts.tagged_with(@tag) unless @tag.blank?
  end

  def show
    @post = Post.friendly.find(params[:id])
  end

end
