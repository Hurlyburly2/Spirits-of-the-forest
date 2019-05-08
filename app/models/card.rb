class Card < ApplicationRecord
  validates :spirit, presence: true
  validates :spirit_points, presence: true
  validates :spirit_count, presence: true
  validates :element, presence: true
  validates :image_url, presence: true
  
  def self.get_game_state(game)
    game.gamestate
  end
  
  def self.new_game_state(game)
    cards = Card.all
    cards = cards.shuffle
    row_one = cards[0..11]
    row_two = cards[12..23]
    row_three = cards[24..35]
    row_four = cards[36..47]
    gamestate = {
      row_one: row_one,
      row_two: row_two,
      row_three: row_three,
      row_four: row_four
    }
    tokens = Token.all.shuffle
    gamestate = gamestate.to_json
    gamestate = JSON.parse(gamestate)
    gamestate["row_one"][1]["token"] = tokens.pop
    gamestate["row_one"][10]["token"] = tokens.pop
    gamestate["row_two"][2]["token"] = tokens.pop
    gamestate["row_two"][9]["token"] = tokens.pop
    gamestate["row_three"][3]["token"] = tokens.pop
    gamestate["row_three"][8]["token"] = tokens.pop
    gamestate["row_four"][4]["token"] = tokens.pop
    gamestate["row_four"][7]["token"] = tokens.pop
    
    game.gamestate = gamestate.to_json
    game.save
    game.gamestate
  end
end
