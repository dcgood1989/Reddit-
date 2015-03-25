class AuthenticationController < ApplicationController

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    redirect_to posts_path
    flash[:notice] = "You have successfully signed out"
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully signed in"
      redirect_to posts_path
    else
      render :new
    end
  end

end
