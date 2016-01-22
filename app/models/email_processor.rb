class EmailProcessor
  def initialize(email)
    @email = email
  end
  
  def process
    user = User.find_by_email(@email.from[:email])
    user.entries.create!(content: @email.body) if !has_journaled_today?
  end
  
  def has_journaled_today?
    user.entries.first.try(:created_at).try(:strftime, '%d %B %Y') == Time.now.strftime("%d %B %Y")
  end
end