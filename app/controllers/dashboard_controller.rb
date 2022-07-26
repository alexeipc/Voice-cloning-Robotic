class DashboardController < ApplicationController
  def index
    if not session[:user_id]
      redirect_to '/login' 
    end
  end
end
