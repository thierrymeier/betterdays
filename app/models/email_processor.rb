class EmailProcessor
  def initialize(email)
    @email = email
  end
  
  def process
    user = User.where(email: @email.from).first
    user.entries.create!(
      content: @email.body
    )
  end
end