class DashboardController < ApplicationController
  def record
    if session[:user_id]

      @sentences = [
        "This is sentence 1",
        "This is sentence 2",
        "This is sentence 3",
        "This is sentence 4",
        "This is sentence 5",
        # "This is sentence 6",
        # "This is sentence 7",
        # "This is sentence 8",
        # "This is sentence 9",
        # "This is sentence 10"
      ]
    else
      redirect_to '/login' 
    end
  end

  def submit_voice
    if session[:user_id] 
      @@resource["user-#{session[:user_id]}"].put :voice => params[:voice]
    else
      render :nothing => true, :status => 401
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
      return true
    rescue
      return false
    end
  end
end
