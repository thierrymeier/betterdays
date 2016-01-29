class SessionsController < ApplicationController
  def new
    render :layout => 'login_layout'
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if user.activated?
        session[:user_id] = user.id
        redirect_to entries_path
      else
        flash[:danger] = 'Account not activated. Check your inbox for the activation link.'
        redirect_to root_url
      end
    else
      flash[:danger] = 'Email or password is invalid'
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
  
end
