class User < ActiveRecord::Base
  attr_accessor :activation_token, :reset_token, :new_subscription
  before_save :downcase_email
  before_create :create_activation_digest
  has_many :entries, dependent: :destroy
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 250 }, uniqueness: { 
                    case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, :on => :create
  validates :first_name, presence: true, :on => :create, :on => :edit
  scope :with_reminder, -> { where(reminder: true) }

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  class << self
  
    # Returns the hash digest of the given string
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
    
    # Returns a random token.
      def new_token
        SecureRandom.urlsafe_base64
      end
  end
  
  def new_subscription?
    new_subscription
  end
  
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end
  
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  def send_activation_reminder_email
    UserMailer.activation_reminder(self).deliver_now
  end
  
  def send_start_email
    UserMailer.start_email(self).deliver_now
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  def send_reminder_email
    UserMailer.reminder(self).deliver_now
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  private
  
    # Converts email to lower case
    def downcase_email
      self.email = email.downcase
    end
    
    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
  
end
