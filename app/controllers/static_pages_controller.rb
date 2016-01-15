class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to entries_path
    else
      render :layout => 'landing_layout'
    end
  end

  def help
  end

  def contact
  end
  
  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  
  
end
