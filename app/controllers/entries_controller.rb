class EntriesController < ApplicationController
  before_action :authorize

  def index
    if current_user.nil?
      flash[:info] = "Whoops, you need to log in first."
      redirect_to login_path
    else
      @entries = current_user.entries
      @entry = Entry.new
    end
  end
  
  def show
    if current_user.entries.find_by_id(params[:id]).nil?
      flash[:success] = "Hey, you're not allowed to do that."
      redirect_to root_path
    else
      @entry = current_user.entries.find(params[:id]) if current_user.entries.find_by_id(params[:id])
    end
  end
  
  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id
    if @entry.save
      flash[:success] = "Awesome, your new entry has been filed in the books!"
      redirect_to root_path
    else
      flash[:danger] = "Come on, write at least 50 letters."
      redirect_to root_path
    end
  end

  def edit
    @entry = Entry.find(params[:id])
  end
  
  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(entry_params)
      flash[:success] = "Yay, your entry has been updated"
      redirect_to @entry
    else
      flash[:danger] = "Oh no, we could not update your entry. Try again."
      render 'edit'
    end
  end
  
  def destroy
    @entry = Entry.find(params[:id]).destroy
    flash[:success] = "BOOOOOM, your entry has been destroyed"
    redirect_to root_path
  end
  
  def search
    if params[:search]
      @entries = current_user.entries.search(params[:search]).order("created_at DESC")
    else
      @entries = Entry.all.order("created_at DESC")
    end
  end
  
  private
  
    def entry_params
      params.require(:entry).permit(:content, :location, :user_id)
    end
    
end