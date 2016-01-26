class SubscriptionsController < ApplicationController
  before_action :authorize
  
  def show
  end
  
  def new
  end
  
  def create
    flash.now[:danger] = "Something went wrong, please make sure JavaScript is enabled or AdBlock disabled."
    @user = current_user
    
    if params[:stripeToken].nil?
      render 'new'
    else
      customer =  if current_user.stripe_id?
                    Stripe::Customer.retrieve(current_user.stripe_id)
                  else
                    Stripe::Customer.create(email: current_user.email)
                  end
                
      subscription = customer.subscriptions.create(
        source: params[:stripeToken],
        plan: "monthly"
      )
      
      @user.attributes = {
        :stripe_id => customer.id,
        :stripe_subscription_id => subscription.id,
        :card_last4 => params[:card_last4],
        :card_exp_month => params[:card_exp_month],
        :card_exp_year => params[:card_exp_year],
        :card_brand => params[:card_brand]
      }
  
      @user.save(:validate => false)
      
      flash[:success] = "Yay, we processed your payment and billed your credit card!"
      redirect_to root_path
    end
  end
  
  def destroy
  end
  
end