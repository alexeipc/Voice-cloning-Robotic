class HomeController < ApplicationController
  def index
    if session[:user_id]
      redirect_to '/dashboard'
    end
  end

  def about
  end
end
