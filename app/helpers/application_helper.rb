module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user?(user)
    user == current_user
  end

  def require_login
    redirect_to login_path unless logged_in?
  end

  def require_admin
    redirect_to '/' unless current_user.admin?
  end

  def require_current_user
    redirect_to '/' unless current_user?(@user)
  end
end
