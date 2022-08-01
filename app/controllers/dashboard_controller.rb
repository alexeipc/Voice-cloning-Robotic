class DashboardController < ApplicationController
  def index
    if not session[:user_id]
      redirect_to '/login' 
    end
    
  end

  def change_password
    @user = User.find_by(id: session[:user_id])
    if (params[:new_password] == params[:new_password_confirmation]) && @user.authenticate(params[:old_password])
      #Save to Database
      
      @user.password = params[:new_password]
      @user.save

      # Announce
      
      redirect_to dashboard_path, success: "Congrat! Change password successfully"
    else
      #flash[:error] = "Wrong password"
      redirect_to dashboard_path, danger: "Wrong password, LOL!"
    end
  end

  def change_infor
    
  end

end
