class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, length: { maximum: 255 }
  validates :password, length: { minimum: 6 }
  validates_uniqueness_of :email
end
