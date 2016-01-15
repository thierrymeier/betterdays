class UsersController < ApplicationController
  before_action :authorize, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      # session[:user_id] = @user.id – Here, we automatically logged someone in.
      # flash[:success] = "You're signed up – yay!"
      flash[:info] = "Check out your inbox to activate your account."
      redirect_to login_path
    else
      render 'new'
      flash.now[:danger] = "Hm, something went wrong. Try again."
    end
  end
  
  def edit
    # @user is defined in correct_user that is being called before_action
    @show_trial_alert = true
  end
  
  def update
    # @user is defined in correct_user that is being called before_action
    if @user.update_attributes(user_params)
      flash.now[:success] = "Kaboom, your account has been updated"
      render 'edit'
    else
      flash.now[:danger] = "Uh oh, we could not update your account. Try again."
      render 'edit'
    end
  end
  
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :reminder)
    end
  
end
