class SessionsController < ApplicationController
  def new
    if session[:user_id]
      redirect_to '/dashboard'
    elsif session[:admin_i]
      redirect_to '/admin'
    end
  end

  def create
    user = User.find_by(email: params[:email])

    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
