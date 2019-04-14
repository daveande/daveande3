class Admin::ContentMagnetsController < Admin::BaseController

  def index
    @magnets = ContentMagnet.order('id desc').all
    @magnet = ContentMagnet.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @magnet = ContentMagnet.new(magnet_params)
    respond_to do |format|
      if @magnet.save
        format.html { redirect_to admin_content_magnets_url, notice: "Saved successfully." }
      else
        format.html { redirect_to admin_images_url, alert: "Could not save file." }
      end
    end
  end

  def show
    @magnet = ContentMagnet.find(params[:id])
    redirect_to @magnet.asset.expiring_url(30)
  end

  def destroy
    @magnet = ContentMagnet.find(params[:id])
    @magnet.destroy
    respond_to do |format|
      format.html { redirect_to admin_content_magnets_url, notice: "Deleted" }
    end
  end

  private

    def magnet_params
      params.require(:content_magnet).permit(
        :title,
        :description,
        :asset
      )
    end

end
