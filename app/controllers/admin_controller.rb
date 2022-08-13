class AdminController < ApplicationController

  def login
    if session[:admin_id]
      redirect_to '/admin/dashboard'
    end
  end

  def create
    if params[:admin_password] == ENV['ADMIN_PASSWORD']
      session[:admin_id] = -1
      redirect_to '/admin/dashboard'
    else
      redirect_to '/admin'
    end
  end

  def dashboard
    if session[:admin_id] == -1

    else
      redirect_to '/admin'
    end
  end

  def logout
    session[:admin_id] = nil
    redirect_to '/'
  end
end