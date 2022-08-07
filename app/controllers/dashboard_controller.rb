class DashboardController < ApplicationController
  def record
    if session[:user_id]

      @sentences = [
        "This is sentence 1",
        "This is sentence 2",
        "This is sentence 3",
        "This is sentence 4",
        # "This is sentence 5",
        # "This is sentence 6",
        # "This is sentence 7",
        # "This is sentence 8",
        # "This is sentence 9",
        # "This is sentence 10"
      ]
    else
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

  def delete_voice
    if session[:user_id]
      puts "Deleting voice"
      @@resource["user-#{session[:user_id]}"].delete
      redirect_to '/dashboard'
    else 
      redirect_to '/login'
    end
  end

  def submit_voice
    if session[:user_id] 
      @@resource["user-#{session[:user_id]}"].put :voice => params[:voice]
      redirect_to '/dashboard'
    else
      redirect_to '/login'
    end
  end

  def index
    if session[:user_id]
      @voice_status = get_voice_status
    else
      redirect_to '/login' 
    end
  end

  private
  @@API_URL = ENV['API_URL'] || 'localhost:3000'
  @@resource = RestClient::Resource.new @@API_URL

  def get_voice_status
    begin
      response = @@resource["user-#{session[:user_id]}"].get
      return true
    rescue
      return false
    end
  end
end
