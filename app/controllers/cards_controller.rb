class CardsController < ApplicationController
  before_action :authorize
  before_action :correct_user
  
  def update
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    subscription = customer.subscriptions.retrieve(current_user.stripe_subscription_id)
    subscription.source = params[:stripeToken]
    subscription.save
    
    @user.attributes = {
        :card_last4 => params[:card_last4],
        :card_exp_month => params[:card_exp_month],
        :card_exp_year => params[:card_exp_year],
        :card_brand => params[:card_brand]
      }
  
      @user.save(:validate => false)
      
      flash[:success] = "Yay, we updated your credit card!"
      redirect_to edit_user_path
    
  end
  
end