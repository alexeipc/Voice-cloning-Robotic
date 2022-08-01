class ApplicationController < ActionController::Base
  before_action :set_current_user

  add_flash_types :danger_infor, :danger, :infor, :warning, :success

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])   
    end
  end
end
