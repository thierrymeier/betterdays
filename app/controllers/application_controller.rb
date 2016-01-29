class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_action :set_time_zone, if: :current_user
  
  def authorize
    if current_user.nil?
      redirect_to login_path
    end
  end
  
  def is_subscribed?
    current_user.stripe_subscription_id
  end
  helper_method :is_subscribed?
  
  def is_on_trial?
    current_user.created_at > 14.days.ago
  end
  helper_method :is_on_trial?
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def set_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end
  
end
