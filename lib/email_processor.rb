class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    # all of your application-specific code here - creating models,
    # processing reports, etc

    # here's an example of model creation
    user = Entry.find_by_email(@email.from[:email])
    user.entries.create!(
      content: @email.body
    )
  end
end