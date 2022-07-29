class DashboardController < ApplicationController
  def record
    if not session[:user_id]
      redirect_to '/login' 
    end
  end

  def index
    @voice_status = get_voice_status
    if not session[:user_id]
      redirect_to '/login' 
    end
  end

  private
  def get_voice_status
    return 'Not recorded'
  end
end
