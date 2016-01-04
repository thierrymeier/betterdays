class Entry < ActiveRecord::Base
  validates :content,  presence: true, length: { minimum: 50 }
end
