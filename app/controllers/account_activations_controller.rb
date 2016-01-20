class AccountActivationsController < ApplicationController
  
  def edit 
      user = User.find_by(email: params[:email])
      if user && !user.activated? && user.authenticated?(:activation, params[:id])
          user.activate
          user.send_start_email
          session[:user_id] = user.id
          flash[:success] = "Account activated"
          redirect_to entries_path
      else
          flash[:danger] = "Invalid activation link"
          redirect_to root_path
      end
  end
  
end
