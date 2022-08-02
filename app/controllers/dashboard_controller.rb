require 'uri'
require 'net/http'


class DashboardController < ApplicationController
  def record
    if not session[:user_id]
      redirect_to '/login' 
    end
  end

  def index
    if session[:user_id]
      @voice_status = get_voice_status
    else
      redirect_to '/login' 
    end
  end

  private
  @@API_URL = ENV['API_URL'] || 'localhost:3000'
  @@resource = RestClient::Resource.new @@API_URL

  def get_voice_status
    begin
      response = @@resource["user-#{session[:user_id]}"].get
      return "Recorded"
    rescue
      return "Not recorded"
    end
  end
end
