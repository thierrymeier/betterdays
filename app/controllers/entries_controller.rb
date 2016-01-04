class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def index
    @entries = Entry.all.order('entries.created_at DESC')
    @entry = Entry.new
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
    @entry.save
    respond_to do |x|
      
      if @entry.save
        x.html { redirect_to root_path, notice: 'Entry was successfully created.' }
      else
        x.html { render :new, notice: 'Entry could not be saved.' }
      end
    end
  end
  
  private
    def entry_params
      params.require(:entry).permit(:content, :location)
    end
end
