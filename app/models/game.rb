class Game < ApplicationRecord
  has_many :matches, dependent: :destroy
  has_many :users, through: :matches
  
  def self.concede_game_timeout(game)
    returnGameState = "done"
    idle_user = User.find(game.whose_turn_id)
    winner = game.users.where.not(id: idle_user.id)[0]
    winner.wins += 1
    idle_user.losses += 1
    winner = User.ranking_change(winner, "win")
    idle_user = User.ranking_change(idle_user, "loss")
    winner.save
    idle_user.save
    
    game.winner_id = winner.id
    game.whose_turn_id = nil
    game.gamestate = nil
    game.concession = true
    game.save
  end
end
