require 'hashids'

module HashidsSupport
  module ClassMethods
    def hashids
      Hashids.new("2mWy92kmDaLd", 10)
    end

    def encrypt_id(id)
      hashids.encode(id)
    end

    def decrypt_id(id)
      hashids.decode(id).first
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def encrypted_id
    self.class.encrypt_id(id)
  end

  def to_param
    encrypted_id
  end
end

ActiveRecord::Base.send :include, HashidsSupport