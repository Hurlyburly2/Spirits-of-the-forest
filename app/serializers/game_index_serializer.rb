class GameIndexSerializer < ActiveModel::Serializer
  attributes :id, :whose_turn_id
  
  has_many :users
end
