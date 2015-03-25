class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :ensure_current_user

  def current_user
    User.find_by_id(session[:user_id])
  end

  def ensure_current_user
    unless current_user
      flash[:notice] = "You must sign in"
      redirect_to sign_in_path
    end
  end



end
