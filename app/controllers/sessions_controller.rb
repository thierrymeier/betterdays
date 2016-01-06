class SessionsController < ApplicationController
  def new
    render :layout => 'login_layout'
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Wowza, you are logged in!'
      redirect_to entries_path
    else
      flash[:danger] = 'Email or password is invalid'
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:info] = 'Please come again!'
    redirect_to login_path
  end
  
end
