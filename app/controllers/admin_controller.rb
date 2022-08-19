class AdminController < ApplicationController

  def login
    if session[:admin_id]
      redirect_to admin_dashboard_path
    end
  end

  def create
    if params[:admin_password] == ENV['ADMIN_PASSWORD']
      session[:admin_id] = -1
      redirect_to admin_dashboard_path
    else
      redirect_to admin_path
    end
  end   # end of create

  def dashboard
    if session[:admin_id] == -1
      @users = User.all
    else
      redirect_to admin_path
    end
  end

  def logout
    session[:admin_id] = nil
    redirect_to '/'
  end

  def users
    if session[:admin_id] == -1
      @users = User.all
    else
      redirect_to admin_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
      @user = User.new(user_params)
      @user.save

    if @user.save
      session.delete(:user_id)
      redirect_to admin_users_path
    else
      redirect_to admin_users_path
    end
  end

  def destroy
    p "hello"
    @user = User.find(params[:id])
    @user.destroy
    @user.save
    if @user.destroy
      redirect_to admin_users_path, notice: "User deleted."
    else
      redirect_to admin_path, flash: { error: "User could not be deleted." }
    end
  end

  def show
    if session[:admin_id] == -1
      @user = User.find(params[:id])
    else
      redirect_to admin_path
    end
  end

  private 
  def user_params
    params.permit(:email, :password)
  end

end
