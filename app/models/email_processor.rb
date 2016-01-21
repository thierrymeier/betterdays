class EmailProcessor
  def initialize(email)
    @email = email
  end
  
  def process
    user = User.where(email: email).first
    user.entries.create!(
      content: @email.body
    )
  end
end