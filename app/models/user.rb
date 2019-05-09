class User < ApplicationRecord
  has_many :matches
  has_many :games, through: :matches
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, presence: true, length: { minimum: 2, maximum: 15 }, uniqueness: true
  # email seems to be automatically validated
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
   def after_database_authentication
     binding.pry
   end
end
