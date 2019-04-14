class SubscribersController < ApplicationController

  def create
    @response = subscribe_to_newsletter
    @msg_location_id = params[:location]
    respond_to do |format|
      format.js 
    end
  end

  def new
    respond_to do |format|
      format.js
    end
  end

  private

    def subscribe_to_newsletter
      drip = ::Drip::Client.new do |c|
        c.api_key = Rails.application.secrets.drip_api_token
        c.account_id = Rails.application.secrets.drip_account_id
      end

      rsp = drip.create_or_update_subscriber(params["email"], {
          "time_zone" => browser_timezone
      })
    end

end

