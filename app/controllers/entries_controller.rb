class EntriesController < ApplicationController
  before_action :authorize
  before_action :correct_user

  def index
    @entry = Entry.new
  end
  
  def show
    if @entries.find_by_id(params[:id]).nil?
      flash[:danger] = "Hey, you're not allowed to do that."
      redirect_to root_path
    else
      @entry = @entries.find(params[:id])
    end
  end
  
  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id
    if @entry.save
      flash[:success] = "Awesome, your new entry has been filed in the books!"
      redirect_to root_path
    else
      flash.now[:danger] = "Come on, your life is more interesting than that. Write a bit more!"
      render 'index'
    end
  end

  def edit
    if @entries.find_by_id(params[:id]).nil?
      flash[:danger] = "Hey, you're not allowed to do that."
      redirect_to root_path
    else
      @entry = @entries.find(params[:id])
    end
  end
  
  def update
    @entry = @entries.find(params[:id])
    if @entry.update_attributes(entry_params)
      flash[:success] = "Yay, your entry has been updated"
      redirect_to @entry
    else
      flash.now[:danger] = "Oh no, we could not update your entry. Try again."
      render 'edit'
    end
  end
  
  def destroy
    @entry = @entries.find(params[:id]).destroy
    flash[:success] = "BOOOOOM, your entry has been destroyed"
    redirect_to root_path
  end
  
  def search
    if params[:search]
      @search_entries = @entries.search(params[:search]).order("created_at DESC")
    else
      @entries = Entry.all.order("created_at DESC")
    end
  end
  
  private
  
    def entry_params
      params.require(:entry).permit(:content, :location, :user_id)
    end
    
    def correct_user
      @entries = current_user.entries
      redirect_to root_url if @entries.nil?
    end
    
end