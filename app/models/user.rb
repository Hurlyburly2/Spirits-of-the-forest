class User < ApplicationRecord
  has_many :matches
  has_many :games, through: :matches
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, presence: true, length: { minimum: 2, maximum: 15 }, uniqueness: true
  # email seems to be automatically validated
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
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
end
