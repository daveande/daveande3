class Admin::ImagesController < Admin::BaseController

  def index
    @images = Image.order('id desc').all
    @image = Image.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @image = Image.new(image_params)
    respond_to do |format|
      if @image.save
        format.html { redirect_to admin_images_url, notice: "Saved successfully." }
        format.json { render json: {
          id: @image.id, 
          media: {
            original_url: @image.media.url,
            thumb_url: @image.media.url(:thumb)
          }
        }}
      else
        format.html { redirect_to admin_images_url, alert: "Could not save file." }
        format.json { render json: {error: "Failed to process."}, status: 422 } 
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    respond_to do |format|
      format.html { redirect_to admin_images_url, notice: "Deleted image" }
      format.js
    end
  end

  private

    def image_params
      params.require(:image).permit(
        :media
      )
    end

end
