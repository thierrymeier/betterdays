class Entry < ActiveRecord::Base
  validates :content,  presence: true, length: { minimum: 50 }
  
  
  def self.search(search)
    where("content LIKE ? OR created_at LIKE ?", "%#{search}%", "%#{search}%") 
  end
  
end
