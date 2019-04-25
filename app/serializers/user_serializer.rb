class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  
  has_many :games, through: :matches
end
