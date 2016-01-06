class UsersController < ApplicationController
  before_action :authorize, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You're signed up – yay!"
      redirect_to root_path
    else
      render "new"
    end
  end
  
  def edit
    # @user is defined in correct_user that is being called before_action
  end
  
  def update
    # @user is defined in correct_user that is being called before_action
    if @user.update_attributes(user_params)
      flash[:success] = "Kaboom, your account has been updated"
      render 'edit'
    else
      flash[:danger] = "Uh oh, we could not update your account. Try again."
      render 'edit'
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    if (@user == current_user) == false
      flash[:danger] = "Not authorized"
      redirect_to root_path
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :reminder)
    end
  
end
