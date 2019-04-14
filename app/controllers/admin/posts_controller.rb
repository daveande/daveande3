class Admin::PostsController < Admin::BaseController

  def index
    @posts = Post.order('published_at desc').select(:id, :title, :published_at).all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Saved."
      redirect_to edit_admin_post_url(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.friendly.find(params[:id])
  end

  def update
    @post = Post.friendly.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "Saved."
      redirect_to edit_admin_post_url(@post)
    else
      render :edit
    end
  end

  private

    def post_params
      params.require(:post).permit(
        :title,
        :subtitle,
        :featured_image_id,
        :body_markdown,
        :is_published,
        :show_on_index,
        :seo_title,
        :meta_description,
        :meta_keywords
      )
    end

end
