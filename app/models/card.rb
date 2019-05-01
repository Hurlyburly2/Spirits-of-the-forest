class Card < ApplicationRecord
  validates :spirit, presence: true
  validates :spirit_points, presence: true
  validates :spirit_count, presence: true
  validates :element, presence: true
  validates :image_url, presence: true
  
  def self.createDeck
    
  end
end
