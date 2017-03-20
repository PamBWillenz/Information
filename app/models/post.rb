class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :message, presence: true

  has_many :comments, dependent: :destroy
  
  belongs_to :user
end
