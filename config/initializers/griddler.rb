Griddler.configure do |config|
  config.email_service = :sendgrid
  config.processor_class = EmailProcessor
  config.processor_method = :process
  config.reply_delimiter = '-- REPLY ABOVE THIS LINE --'
end