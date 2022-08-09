class DashboardController < ApplicationController
  def record
    if session[:user_id]

      @sentences = [
        "This is sentence 1",
        "This is sentence 2",
        "This is sentence 3",
        "This is sentence 4",
        # "This is sentence 5",
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

  def delete_voice
    if session[:user_id]
      puts "Deleting voice"
      user_resource.delete
      redirect_to '/dashboard'
    else 
      redirect_to '/login'
    end
  end

  def submit_voice
    if session[:user_id] 
      user_resource.put :voice => params[:voice]
      redirect_to '/dashboard'
    else
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

  def get_voice_status
    begin
      response = user_resource.get
      return true
    rescue
      return false
    end
  end

  private
  def user_resource
    return @@Resource["user-#{session[:user_id]}"]
  end 
end
