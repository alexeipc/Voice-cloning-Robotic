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
      redirect_to dashboard_path, danger: "Wrong password LOL"
    end
  end

  def change_infor
    @user = User.find_by(id: session[:user_id])

    if @user.authenticate(params[:password])

      @user[:firstname]= params[:first_name]
      @user[:lastname] = params[:last_name]

      @user.save


      redirect_to dashboard_path, success: "Congrat! Change name successfully"
    else
      redirect_to dashboard_path
      redirect_to dashboard_path, danger: "Wrong password LOL"
      
    end


  end

end
