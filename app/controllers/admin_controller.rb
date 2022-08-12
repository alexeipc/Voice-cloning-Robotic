class AdminController < ApplicationController
  def login
  end

  def create
    if params[:admin_password] == ENV['ADMIN_PASSWORD']
      session[:admin_id] = -1
      redirect_to '/admin_dashboard'
    else
      redirect_to '/admin'
    end

  end
end
