class Book < ApplicationRecord
  has_one :user
  
  mount_uploader :book_cover, BookCoverUploader
  
  validates :book_name, presence: true
end
