class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :which_profile_pic, :rank
  
  has_many :games, through: :matches
end
