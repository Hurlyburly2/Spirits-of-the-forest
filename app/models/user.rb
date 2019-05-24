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
   
   def self.return_image_url(rank, which_profile_pic)
     image_url = "/rankicons/"
     case which_profile_pic
     when 1
       image_url += "Branch"
     when 2
       image_url += "Dew"
     when 3
       image_url += "Flower"
     when 4
       image_url += "Fruit"
     when 5
       image_url += "Moss"
     when 6
       image_url += "Mushroom"
     when 7
       image_url += "Moon"
     when 8
       image_url += "Spider"
     when 9
        image_url += "Vine"
      when 10
        image_url += "Leaf"
      when 11
        image_url += "Sun"
      when 12
        image_url += "Wind"
     end
     
     case rank
     when "bronze"
       image_url += "Bronze"
     when "silver"
       image_url += "Silver"
     when "gold"
       image_url += "Gold"
     when "diamond"
       image_url += "Diamond"
     when "master"
       image_url += "Master"
     end
     
     return image_url += ".png"
   end
   
   def self.get_progress_bar_style(rankup_score)
     progress_bar_style = ""
     if rankup_score >= 0 && rankup_score < 100
       rank_up_percentage = rankup_score  
       progress_bar_style = "width:#{rank_up_percentage}%;background-color:#CD7F32;border-width:1px;height:28px"
     elsif rankup_score >= 100 && rankup_score < 200
       rank_up_percentage = rankup_score - 100
       progress_bar_style = "width:#{rank_up_percentage}%;background-color:#C0C0C0;border-width:1px;height:28px"
     elsif rankup_score >= 200 && rankup_score < 300
       rank_up_percentage = rankup_score - 200
       progress_bar_style = "width:#{rank_up_percentage}%;background-color:#FFD700;border-width:1px;height:28px"
     elsif rankup_score >= 300 && rankup_score < 400
       rank_up_percentage = rankup_score - 300
       progress_bar_style = "width:#{rank_up_percentage}%;background-color:#B9F2FF;border-width:1px;height:28px"
     else
       progress_bar_style = "width:100%;background-color:#ff3276;"
     end
   end
end
