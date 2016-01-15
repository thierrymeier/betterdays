class StaticPagesController < ApplicationController
  def home
    render :layout => 'landing_layout'
  end

  def help
  end

  def contact
  end
end
