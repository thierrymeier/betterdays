class User < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  before_save { self.email = email.downcase }
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 250 }, uniqueness: { 
                    case_sensitive: false },format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
end
