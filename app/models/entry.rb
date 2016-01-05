class Entry < ActiveRecord::Base
  validates :content,  presence: true, length: { minimum: 50 }
  
  
  def self.search(search)
    where("content LIKE :pat", :pat => "%#{search}%")
    # where("content LIKE :pat OR to_char(created_at, 'YYYY month Month DD') LIKE :pat", :pat => "%#{search}%") <-- with timestamp search
  end
  
end
