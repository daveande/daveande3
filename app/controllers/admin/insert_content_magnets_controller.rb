class Admin::InsertContentMagnetsController < Admin::BaseController

  def index
    @magnets = ContentMagnet.order('id desc').all
    respond_to do |format|
      format.js
    end
  end

  def new
    @magnet = ContentMagnet.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @magnet = ContentMagnet.find(params[:id])
    @title = params[:title]
    @body = params[:body]
    @button = params[:button_text]
    respond_to do |format|
      format.json { render json: {
        callout_html: (render_to_string partial: "admin/insert_content_magnets/content_magnet_callout.html.haml"),
        title: @title,
        body: @body,
        button: @button,
        url: content_magnet_url(@magnet)
      }}
    end
  end

end
