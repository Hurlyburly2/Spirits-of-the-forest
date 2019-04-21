class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, presence: true, length: { minimum: 2, maximum: 15 }, uniqueness: true
  # email seems to be automatically validated
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end