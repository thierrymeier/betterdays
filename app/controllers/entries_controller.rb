class EntriesController < ApplicationController
before_action :authorize

  def index
    if current_user.nil?
      redirect_to login_path, notice: 'Please log in!'
    else
      @entries = current_user.entries
      @entry = Entry.new
    end
  end
  
  def show
    if current_user.entries.find_by_id(params[:id]).nil?
      redirect_to root_path, notice: 'You can not do this'
    else
      @entry = current_user.entries.find(params[:id]) if current_user.entries.find_by_id(params[:id])
    end
  end
  
  def create
    @entry = Entry.new(entry_params)
    @entry.user_id = current_user.id
    if @entry.save
      redirect_to root_path, notice: 'Entry was successfully created.'
    else
      redirect_to root_path, notice: 'Entry not saved. Write more than 50 characters. Sorry for not saving what you wrote, hihi.'
    end
  end

  def edit
    @entry = Entry.find(params[:id])
  end
  
  def update
    @entry = Entry.find(params[:id])
    respond_to do |y|
    if @entry.update_attributes(entry_params)
      y.html { redirect_to @entry, notice: 'Entry was succcessfully updated.' }
    else
      y.html { render :edit, notice: "Couldn't update entry" }
    end
  end
  end
  
  def destroy
    @entry = Entry.find(params[:id]).destroy
    redirect_to root_path, notice: 'Successfully deleted'
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