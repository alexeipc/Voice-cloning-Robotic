class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :set_query

  add_flash_types :danger_infor, :danger, :infor, :warning, :success

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])   
    end
  end

  def set_query
    @query = User.ransack(params[:q])
  end

  private
  @@API_URL = ENV['API_URL'] || 'localhost:3000'
  @@Resource = RestClient::Resource.new @@API_URL
end
