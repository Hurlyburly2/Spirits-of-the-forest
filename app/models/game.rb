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
  
  def self.get_games_list(user)
    games = user.games
    serialized_games = games.map do |game|
      match = game.matches.where(user: user)[0]
      if match.endgame_confirm == false
        GameIndexSerializer.new(game)
      else
      end
    end
    serialized_games = serialized_games.select do |match|
      match != nil
    end
    
    serialized_games
  end
  
  def self.getScore(current_player, opponent, current_game)
    score = {
      "user" => {
        "branch" => 0,
        "dew" => 0,
        "flower" => 0,
        "fruit" => 0,
        "leaf" => 0,
        "moss" => 0,
        "mushroom" => 0,
        "spider" => 0,
        "vine" => 0,
        "moon" => 0,
        "sun" => 0,
        "wind" => 0,
        "total" => 0
      },
      "opponent" => {
        "branch" => 0,
        "dew" => 0,
        "flower" => 0,
        "fruit" => 0,
        "leaf" => 0,
        "moss" => 0,
        "mushroom" => 0,
        "spider" => 0,
        "vine" => 0,
        "moon" => 0,
        "sun" => 0,
        "wind" => 0,
        "total" => 0
      },
      "winning" => nil
    }
    current_player_cards = JSON.parse(current_game.matches.where(user: current_player)[0].selected_cards)
    current_player_tokens = JSON.parse(current_game.matches.where(user:current_player)[0].tokens)
    
    opponent_cards = JSON.parse(current_game.matches.where(user: opponent)[0].selected_cards)
    opponent_tokens = JSON.parse(current_game.matches.where(user: opponent)[0].tokens)
    
    current_player_cards.each do |card|
      score["user"][card["spirit"]] += card["spirit_points"]
      if card["element"] == "sun"
        score["user"]["sun"] += 1
      elsif card["element"] == "moon"
        score["user"]["moon"] += 1
      elsif card["element"] == "wind"
        score["user"]["wind"] += 1
      end
    end
    
    current_player_tokens.each do |token|
      if token["spirit"] != "plus-1" && token["spirit"] != "plus-2"
        score["user"][token["spirit"]] += 1
      end
    end
    
    opponent_cards.each do |card|
      score["opponent"][card["spirit"]] += card["spirit_points"]
      if card["element"] == "sun"
        score["opponent"]["sun"] += 1
      elsif card["element"] == "moon"
        score["opponent"]["moon"] += 1
      elsif card["element"] == "wind"
        score["opponent"]["wind"] += 1
      end
    end
    
    opponent_tokens.each do |token|
      if token["spirit"] != "plus-1" && token["spirit"] != "plus-2"
        score["opponent"][token["spirit"]] += 1
      end
    end
    
    if score["user"]["branch"] > score["opponent"]["branch"]
      score["user"]["total"] += score["user"]["branch"]
      if score["opponent"]["branch"] == 0
        score["opponent"]["total"] -= 3
      end
    elsif score["user"]["branch"] < score["opponent"]["branch"]
      score["opponent"]["total"] += score["opponent"]["branch"]
      if score["user"]["branch"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["branch"]
      score["opponent"]["total"] += score["opponent"]["branch"]
    end
    
    if score["user"]["dew"] > score["opponent"]["dew"]
      score["user"]["total"] += score["user"]["dew"]
      if score["opponent"]["dew"] == 0
        score["opponent"]["total"] -= 3
      end
    elsif score["user"]["dew"] < score["opponent"]["dew"]
      score["opponent"]["total"] += score["opponent"]["dew"]
      if score["user"]["dew"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["dew"]
      score["opponent"]["total"] += score["opponent"]["dew"]
    end
    
    if score["user"]["flower"] > score["opponent"]["flower"]
      score["user"]["total"] += score["user"]["flower"]
      if score["opponent"]["flower"] == 0
        score["opponent"]["total"] -= 3
      end
    elsif score["user"]["flower"] < score["opponent"]["flower"]
      score["opponent"]["total"] += score["opponent"]["flower"]
      if score["user"]["flower"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["flower"]
      score["opponent"]["total"] += score["opponent"]["flower"]
    end
    
    if score["user"]["fruit"] > score["opponent"]["fruit"]
      if score["opponent"]["fruit"] == 0
        score["opponent"]["total"] -= 3
      end
      score["user"]["total"] += score["user"]["fruit"]
    elsif score["user"]["fruit"] < score["opponent"]["fruit"]
      score["opponent"]["total"] += score["opponent"]["fruit"]
      if score["user"]["fruit"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["fruit"]
      score["opponent"]["total"] += score["opponent"]["fruit"]
    end
    
    if score["user"]["leaf"] > score["opponent"]["leaf"]
      score["user"]["total"] += score["user"]["leaf"]
      if score["opponent"]["leaf"] == 0
        score["opponent"]["total"] -= 3
      end
    elsif score["user"]["leaf"] < score["opponent"]["leaf"]
      score["opponent"]["total"] += score["opponent"]["leaf"]
      if score["user"]["leaf"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["leaf"]
      score["opponent"]["total"] += score["opponent"]["leaf"]
    end
      
    if score["user"]["moss"] > score["opponent"]["moss"]
      score["user"]["total"] += score["user"]["moss"]
      if score["opponent"]["moss"] == 0
        score["opponent"]["total"] -= 3
      end
    elsif score["user"]["moss"] < score["opponent"]["moss"]
      score["opponent"]["total"] += score["opponent"]["moss"]
      if score["user"]["moss"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["moss"]
      score["opponent"]["total"] += score["opponent"]["moss"]
    end
    
    if score["user"]["mushroom"] > score["opponent"]["mushroom"]
      score["user"]["total"] += score["user"]["mushroom"]
      if score["opponent"]["mushroom"] == 0
        score["opponent"]["total"] -= 3
      end
    elsif score["user"]["mushroom"] < score["opponent"]["mushroom"]
      score["opponent"]["total"] += score["opponent"]["mushroom"]
      if score["user"]["mushroom"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["mushroom"]
      score["opponent"]["total"] += score["opponent"]["mushroom"]
    end
    
    if score["user"]["spider"] > score["opponent"]["spider"]
      score["user"]["total"] += score["user"]["spider"]
      if score["opponent"]["spider"] == 0
        score["opponent"]["total"] -= 3
      end
    elsif score["user"]["spider"] < score["opponent"]["spider"]
      score["opponent"]["total"] += score["opponent"]["spider"]
      if score["user"]["spider"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["spider"]
      score["opponent"]["total"] += score["opponent"]["spider"]
    end
    
    if score["user"]["vine"] > score["opponent"]["vine"]
      score["user"]["total"] += score["user"]["vine"]
      if score["opponent"]["vine"] == 0
        score["opponent"]["total"] -= 3
      end
    elsif score["user"]["vine"] < score["opponent"]["vine"]
      score["opponent"]["total"] += score["opponent"]["vine"]
      if score["user"]["vine"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["vine"]
      score["opponent"]["total"] += score["opponent"]["vine"]
    end
    
    if score["user"]["moon"] > score["opponent"]["moon"]
      score["user"]["total"] += score["user"]["moon"]
      if score["opponent"]["moon"] == 0
        score["opponent"]["total"] -= 3
      end
    elsif score["user"]["moon"] < score["opponent"]["moon"]
      score["opponent"]["total"] += score["opponent"]["moon"]
      if score["user"]["moon"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["moon"]
      score["opponent"]["total"] += score["opponent"]["moon"]
    end
    
    if score["user"]["sun"] > score["opponent"]["sun"]
      score["user"]["total"] += score["user"]["sun"]
      if score["opponent"]["sun"] == 0
        score["opponent"]["total"] -= 3
      end
    elsif score["user"]["sun"] < score["opponent"]["sun"]
      score["opponent"]["total"] += score["opponent"]["sun"]
      if score["user"]["sun"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["sun"]
      score["opponent"]["total"] += score["opponent"]["sun"]
    end
    
    if score["user"]["wind"] > score["opponent"]["wind"]
      score["user"]["total"] += score["user"]["wind"]
      if score["opponent"]["wind"] == 0
        score["opponent"]["total"] -= 3
      end
    elsif score["user"]["wind"] < score["opponent"]["wind"]
      score["opponent"]["total"] += score["opponent"]["wind"]
      if score["user"]["wind"] == 0
        score["user"]["total"] -= 3
      end
    else
      score["user"]["total"] += score["user"]["wind"]
      score["opponent"]["total"] += score["opponent"]["wind"]
    end
    
    if score["user"]["total"] > score["opponent"]["total"]
      score["winning"] = "user"
    elsif score["user"]["total"] < score["opponent"]["total"]
      score["winning"] = "opponent"
    else
      score["winning"] = "tie"
    end
    
    return score
  end
  
  def self.remove_cards_from_row(card, row, cards, current_match, tokens)
    if cards[row].any? { |find_card| find_card["id"] == card[:id]}
      if cards[row][0]["id"] == card[:id]
        if cards[row][0]["token"]
          if cards[row][0]["token"]["spirit"] == "plus-1" || cards[row][0]["token"]["spirit"] == "plus-2"
            current_match.gems_possessed += 1
            current_match.gems_total += 1
            current_match.save
          end
          tokens << cards[row][0]["token"]
        end
        if cards[row][0]["gem"]
          current_match.gems_possessed += 1
          current_match.save
        end
        cards[row].shift
      elsif cards[row].last["id"] == card[:id]
        if cards[row].last["token"]
          if cards[row].last["token"]["spirit"] == "plus-1" || cards[row].last["token"]["spirit"] == "plus-2"
            current_match.gems_possessed += 1
            current_match.gems_total += 1
            current_match.save
          end
          tokens << cards[row].last["token"]
        end
        if cards[row].last["gem"]
          current_match.gems_possessed += 1
          current_match.save
        end
        cards[row].pop
      else
        error = "Invalid selection"
      end
    end
    
    return cards, tokens
  end
end
