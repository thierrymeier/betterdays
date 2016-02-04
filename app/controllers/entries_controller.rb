class EntriesController < ApplicationController
  before_action :authorize
  before_action :correct_user
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def index
    @entry = Entry.new
    update_intercom
  end
  
  def show
    @entry = @entries.find Entry.decrypt_id(params[:id])
  end
  
  def create
    @entry = @entries.build(entry_params)
    @user = User.find(session[:user_id])
    if @entry.save 
      current_user.update_attribute(:reminder_count, 0)
      flash[:success] = "Awesome, your new entry has been filed in the books!"
      redirect_to entries_path
    else
      render 'index'
    end
  end

  def edit
    @entry = @entries.find Entry.decrypt_id(params[:id])
  end
  
  def update
    @entry = @entries.find Entry.decrypt_id(params[:id])
    if @entry.update_attributes(entry_params)
      flash[:success] = "Yay, your entry has been updated"
      redirect_to @entry
    else
      flash.now[:danger] = "Oh no, we could not update your entry. Try again."
      render 'edit'
    end
  end
  
  def destroy
    @entry = @entries.find Entry.decrypt_id(params[:id])
    @entry.destroy
    flash[:success] = "Pow! Your entry has been deleted!"
    redirect_to root_path
  end
  
  def search
    @search_entries = @entries.search(params[:search])
  end
  
  private
  
    def record_not_found
      flash[:danger] = "Hey, you're not allowed to do that."
      redirect_to root_path
    end
    
    def update_intercom
      intercom = Intercom::Client.new(app_id: INTERCOM_APP_ID, api_key: INTERCOM_API_KEY)
      intercom_user = intercom.users.create(:user_id => current_user.id, :name => current_user.first_name, :email => current_user.email, :signed_up_at => current_user.created_at, :last_seen_ip => request.remote_ip, :last_request_at => Time.now)
      intercom_user.custom_attributes["post_count"] = current_user.entries.count
      intercom_user.custom_attributes["last_post"] = current_user.entries.first.created_at if @entries.any?
      intercom_user.custom_attributes["activated"] = current_user.activated
      intercom.users.save(intercom_user)
    end
  
    def entry_params
      params.require(:entry).permit(:content)
    end
    
    def correct_user
      @entries = current_user.entries
      redirect_to root_url if @entries.nil?
    end
    
    helper_method :has_journaled_today?
    
    def has_journaled_today?
      @entries.first.try(:created_at).try(:strftime, '%d %B %Y') == Time.current.strftime("%d %B %Y")
    end
    
    helper_method :has_journaled_yesterday?
    
    def has_journaled_yesterday?
      @entries.last.try(:created_at).try(:strftime, '%d %B %>') >= 1.day.ago.strftime("%d %B %Y")
    end
    
end