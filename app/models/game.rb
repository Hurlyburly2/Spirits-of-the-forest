class Game < ApplicationRecord
  has_many :matches, dependent: :destroy
  has_many :users, through: :matches
end
