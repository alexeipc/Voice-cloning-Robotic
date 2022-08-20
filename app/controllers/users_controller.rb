class UsersController < ApplicationController

  def register
    if session[:user_id]
      redirect_to '/dashboard'
    else
      @user = User.new
    end
  end

  def create

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id 
      redirect_to '/dashboard'
    else
      render :register
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private 
  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end
end