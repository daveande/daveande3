class TagsController < ApplicationController
  
  def show
    @tag_str = params[:id]
    @resources = Resource.tagged_with(params[:id])
  end

end
