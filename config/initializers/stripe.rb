#Rails.configuration.stripe = {
#   :publishable_key => ENV['PUBLISHABLE_KEY'] ||= Rails.application.secrets.stripe_publishable_key,
#   :secret_key      => ENV['SECRET_KEY'] ||= Rails.application.secrets.stripe_secret_key
#}

Stripe.api_key = STRIPE_SECRET