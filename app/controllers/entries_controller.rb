class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def index
    @entries = Entry.all.order('entries.created_at DESC')
    @entry = Entry.new
    
    if params[:search]
      @entries = Entry.search(params[:search]).order("created_at DESC")
    else
      @entries = Entry.all.order("created_at DESC")
    end
  end
  
  def search
    if params[:search]
      @entries = Entry.search(params[:search]).order("created_at DESC")
    else
      @entries = Entry.all.order("created_at DESC")
    end
  end

  def show
    @entry = Entry.find(params[:id])
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
  
  def create
    @entry = Entry.new(entry_params)
    respond_to do |x|
      if @entry.save
        x.html { redirect_to root_path, notice: 'Entry was successfully created.' }
      else
        x.html { redirect_to root_path, notice: 'Entry not saved. Write more than 50 characters. Sorry for not saving what you wrote, hihi.' }
      end
    end
  end
  
  def destroy
    @entry = Entry.find(params[:id]).destroy
    flash[:success] = "Entry successfully deleted."
    redirect_to root_path
  end
  
  private
    def entry_params
      params.require(:entry).permit(:content, :location)
    end
    
end
