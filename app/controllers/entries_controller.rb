class EntriesController < ApplicationController
  def new
    @entry = Entry.new
  end

  def index
    @entries = Entry.all
    @entry = Entry.new
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def edit
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
