class Entry < ActiveRecord::Base
  validates :content,  presence: true, length: { minimum: 50 }
  
  
  def self.search(search)
    where("content ILIKE ? OR created_at ILIKE ?", "%#{search}%", "%#{search}%") 
  end
  
end
