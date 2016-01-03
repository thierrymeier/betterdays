class EntriesController < ApplicationController
  def new
  end

  def index
    @entries = Entry.all
  end

  def show
  end

  def edit
  end
end
