class Comment < ActiveRecord::Base
  
  validates :message, presence: true

  belongs_to :post
  belongs_to :user
end
