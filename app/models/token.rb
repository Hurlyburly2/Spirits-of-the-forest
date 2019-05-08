class Token < ApplicationRecord
  validates :spirit, presence: true
  validates :image_url, presence: true
end
