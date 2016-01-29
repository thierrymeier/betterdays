class SubscriptionsController < ApplicationController
  before_action :authorize
  
  def show
  end
  
  def new
  end
  
  def create
    if params[:stripeToken].nil?
      flash.now[:danger] = "Something went wrong, please make sure JavaScript is enabled or AdBlock disabled."
      redirect_to new_subscription_path
    else
      @user = current_user
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
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(stripe_subscription_id: nil)
  
    current_user.attributes = {
        :stripe_subscription_id => nil
    }
  
    current_user.save(:validate => false)
  
    flash[:success] = "We have cancelled your account – but.. we're sad :(."
    redirect_to root_path
  end
end