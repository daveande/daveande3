class ContentMagnetsController < ApplicationController

  def show
    @magnet = ContentMagnet.find(params[:id])
    if params[:magnet_token] == @magnet.token
      redirect_to @magnet.asset.expiring_url(30)
    else
      flash[:error] = "We could not find that piece of content. Please email us if you're having trouble."
      redirect_to root_url
    end
  end

  def new_subscriber
    @magnet = ContentMagnet.find(params[:content_magnet_id])
    respond_to do |format|
      format.js
    end
  end

  def subscribe
    @magnet = ContentMagnet.find(params[:content_magnet_id])
    @response = subscribe_to_newsletter(params[:email], {
      "custom_fields" => {
        "name" => params[:name],
        "campaign_name" => "content_magnet_#{@magnet.id}"
      }, 
      "tags" => [
        "Newsletter", 
        "content_magnet_#{@magnet.id}",
      ]
    })

    if @response.status == 200
      ContentMagnetMailer.send_magnet(params[:email], params[:name], @magnet.id).deliver_later
    end

    respond_to do |format|
      format.js {render json: {status: @response.status, body: @response.body}}
    end
  end

  private

    def subscribe_to_newsletter(email, opts={})
      drip = ::Drip::Client.new do |c|
        c.api_key = Rails.application.secrets.drip_api_token
        c.account_id = Rails.application.secrets.drip_account_id
      end

      opts = opts.merge("time_zone" => browser_timezone)

      rsp = drip.create_or_update_subscriber(email, opts)
    end

end
