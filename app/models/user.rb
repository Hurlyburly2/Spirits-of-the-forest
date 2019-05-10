class User < ApplicationRecord
  has_many :matches
  has_many :games, through: :matches
  
  before_create :initial_profile_pic
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, presence: true, length: { minimum: 2, maximum: 15 }, uniqueness: true
  # email seems to be automatically validated
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
   def initial_profile_pic
     self.which_profile_pic = rand(1..10)
   end
         
   def self.ranking_change(player, game_result)
     if player.rank == "bronze"
       if game_result == "loss"
         player.rankup_score = player.rankup_score - 3
         if player.rankup_score < 0
           player.rankup_score = 0
         end
       else
         player.rankup_score = player.rankup_score + 10
       end
     elsif player.rank == "silver"
       if game_result == "loss"
         player.rankup_score = player.rankup_score - 4
       else
         player.rankup_score = player.rankup_score + 10
       end
     elsif player.rank == "gold"
       if game_result == "loss"
         player.rankup_score = player.rankup_score - 5
       else
         player.rankup_score = player.rankup_score + 10
       end
     elsif player.rank == "diamond"
       if game_result == "loss"
         player.rankup_score = player.rankup_score - 7
       else
         player.rankup_score = player.rankup_score + 10
       end
     else
       if game_result == "loss"
         player.rankup_score = player.rankup_score - 9
       else
         player.rankup_score = player.rankup_score + 10
       end
     end
     
     if player.rankup_score >= 0 && player.rankup_score < 100
       player.rank = "bronze"
     elsif player.rankup_score >= 100 && player.rankup_score < 200
       player.rank = "silver"
     elsif player.rankup_score >= 200 && player.rankup_score < 300
       player.rank = "gold"
     elsif player.rankup_score >= 300 && player.rankup_score < 400
       player.rank = "diamond"
     else
       player.rank = "master"
     end
     player.save
     player
   end
   
   def self.return_image_url(which_profile_pic)
     image_url = ""
     case which_profile_pic
     when 1
       image_url = "/tokens/BranchToken.png"
     when 2
       image_url = "/tokens/DewToken.png"
     when 3
       image_url = "/tokens/FlowerToken.png"
     when 4
       image_url = "/tokens/FruitToken.png"
     when 5
       image_url = "/tokens/MossToken.png"
     when 6
       image_url = "/tokens/MushroomToken.png"
     when 7
       image_url = "/tokens/MoonToken.png"
     when 8
       image_url = "/tokens/SpiderToken.png"
     when 9
        image_url = "/tokens/VineToken.png"
      when 10
        image_url = "/tokens/LeafToken.png"
     end
   end
end
