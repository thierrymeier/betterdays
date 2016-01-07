class Entry < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :content,  presence: true, length: { minimum: 50 }
  validates :user_id, presence: true
  
  
  def self.search(search)
    where("LOWER(content) LIKE LOWER(:pat) or to_char(created_at, 'YYYY month Month DD') LIKE :pat", :pat => "%#{search}%")
    # where("content LIKE :pat OR to_char(created_at, 'YYYY month Month DD') LIKE :pat", :pat => "%#{search}%") <-- with timestamp search
  end
  
end