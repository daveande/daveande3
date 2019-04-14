class SitemapsController < ApplicationController

  def index
    @posts = Post.published
    respond_to do |format|
      format.xml
    end
  end
end
