class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def authorize_admin!
    unless current_user.is_admin
      flash[:error] = "Access Denied"
      redirect_to root_url
    end
  end
end
