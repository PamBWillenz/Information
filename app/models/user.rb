class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :comments

  validates_presence_of :first_name, :last_name

  validates :first_name, presence: true, length: {maximum: 30}
  validates :last_name, presence: true, length: {maximum: 30}       
end
