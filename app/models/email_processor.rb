class EmailProcessor
  def initialize(email)
    @email = email
  end
  
  def process
    user = User.find_by_email(@email.from[:email])
    user.entries.create!(
      content: @email.body
    )
  end
end