class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :browser_timezone

  #cookie is set in app/assets/javascripts/get_timezone.js
  #and uses the vendor/assets/javascripts/jsTimezoneDetect.js library
  def browser_timezone
    cookies[:timezone]
  end

end
