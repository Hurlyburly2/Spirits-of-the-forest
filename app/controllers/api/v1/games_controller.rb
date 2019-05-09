class Api::V1::GamesController < ApplicationController
  def index
    Appstamp.check_for_inactive_games
    
    games = current_user.games
    serialized_games = games.map do |game|
      match = game.matches.where(user: current_user)[0]
      if match.endgame_confirm == false
        GameIndexSerializer.new(game)
      else
      end
    end
    serialized_games = serialized_games.select do |match|
      match != nil
    end
    render json: {
      currentUser: current_user,
      games: serialized_games
    }
  end
  
  def create
    data = JSON.parse(request.body.read)
    new_game = Game.new
    new_match = Match.new(user: User.find(data["id"]), game: new_game, selected_cards: [], tokens: [].to_json)
    if new_game.save && new_match.save
      new_game = GameIndexSerializer.new(new_game)
      
      render json: { games: new_game }
    else
      render json: { error: "ERROR, GAME NOT CREATED" }, status: :unprocessable_entity
    end
  end
  
  def show
    current_game = Game.find(params["id"])
    gameState = ""
    opponent = nil
    winner = nil
    cards = [].to_json
    score = nil
    concession = current_game.concession
    your_tokens = [].to_json
    opponent_tokens = [].to_json
    if (current_game.users.length == 2 && current_game.users.include?(current_user))
      #THIS IS AN IN-PROGRESS GAME OR A COMPLETED/CONCEDED GAME
      if current_game.winner_id == nil
        gameState = "play"
        user = current_user
        opponent = current_game.users.where.not(username: current_user.username)
        score = getScore(user, opponent[0], current_game)
        opponent = UserSerializer.new(opponent[0])
        cards = Card.get_game_state(current_game)
        your_tokens = current_game.matches.where(user: current_user)[0].tokens
        opponent_tokens = current_game.matches.where.not(user: current_user)[0].tokens
        whose_turn = UserSerializer.new(User.find(current_game.whose_turn_id))
      else
        gameState = "complete"
        user = current_user
        opponent = current_game.users.where.not(username: current_user.username)
        score = getScore(user, opponent[0], current_game)
        opponent = UserSerializer.new(opponent[0])
        cards = nil
        whose_turn = nil
        your_tokens = current_game.matches.where(user: current_user)[0].tokens
        opponent_tokens = current_game.matches.where.not(user: current_user)[0].tokens
        winner = UserSerializer.new(User.find(current_game.winner_id))
      end
    elsif (current_game.users.length == 1 && current_game.users[0] == current_user)
      #THIS IS A GAME IN WHICH USER IS WAITING FOR AN OPPONENT
      #THEY SHOULD ONLY HAVE THE OPTION TO DELETE OR GO BACK
      gameState = "pending"
      user = current_user
    elsif (current_game.users.length == 1 && current_game.users[0] != current_user)
      #IF ONE USER AND IT IS NOT CURRENT USER
      #THIS IS A GAME THAT THE USER IS JOINING
      #ADD THE USER TO THE GAME AND CREATE A NEW GAME STATE
      gameState = "play"
      current_game = Game.find(params["id"])
      current_game.whose_turn_id = current_user.id
      new_match = Match.create(game: current_game, user: current_user, selected_cards: [], tokens: [].to_json)
      user = current_user
      opponent = current_game.users.where.not(username: current_user.username)
      opponent = UserSerializer.new(opponent[0])
      
      cards = Card.new_game_state(current_game)
      
      whose_turn = UserSerializer.new(User.find(current_game.whose_turn_id))
    else
      #ELSE ALREADY TWO USERS AND NEITHER ARE CURRENT USER OR NO USERS
      #THIS GAME NO LONGER EXISTS ERROR
      gameState = "error"
    end
    
    opponent_cards = "none".to_json
    if opponent
      opponent_cards = current_game.matches.where.not(user: current_user)[0].selected_cards
    end
    render json: {
      gameState: gameState,
      currentUser: user,
      opponent: opponent,
      cards: cards,
      whose_turn: whose_turn,
      card_reference: Card.all,
      winner: winner,
      yourcards: current_game.matches.where(user: current_user)[0].selected_cards,
      opponentcards: opponent_cards,
      score: score.to_json,
      concession: concession,
      token_reference: Token.all,
      yourTokens: your_tokens,
      opponentTokens: opponent_tokens
    }
  end
  
  def destroy
    winner = nil
    returnGameState = "done"
    concession = false
    if params["gameState"] == "concession"
      game_to_concede = Game.find(params["id"])
      user = params["user"]
      winner = game_to_concede.users.where.not(id: user["id"])[0]
      loser = game_to_concede.users.where(id: user["id"])[0]
      winner.wins += 1
      loser.losses += 1
      winner = ranking_change(winner, "win")
      loser = ranking_change(loser, "loss")
      winner.save
      loser.save
      
      game_to_concede.winner_id = winner.id
      game_to_concede.whose_turn_id = nil
      game_to_concede.gamestate = nil
      game_to_concede.concession = true
      game_to_concede.save
      winner = UserSerializer.new(winner)
      concession = true
    elsif params["gameState"] == "deleteWithoutLoss"
      game_to_delete = Game.find(params["id"])
      game_to_delete.destroy
      returnGameState = "endGameConfirmed"
    elsif params["gameState"] == "confirmGameOver"
      game_to_delete = Game.find(params["id"])
      current_player_match = game_to_delete.matches.where(user_id: params["user"]["id"])[0]
      current_player_match.endgame_confirm = true
      current_player_match.save
      
      both_matches = game_to_delete.matches
      if both_matches[0].endgame_confirm == true && both_matches[1].endgame_confirm == true
        game_to_delete.destroy
      end
      returnGameState = "endGameConfirmed"
    end
    
    render json: { 
      gameState: returnGameState,
      winner: winner,
      concession: concession
    }
  end
  
  def update
    user = User.find(params["currentUser"]["id"])
    game = Game.find(params["id"])
    cards = JSON.parse(game.gamestate)
    selected_cards = params["selected"]
    error = ""
    opponent = game.users.where.not(username: user.username)[0]
    current_match = game.matches.where(user: user)[0]
    score = nil
    tokens = []
    
    if game.whose_turn_id == user.id
      cards_to_remove = params["selected"].map do |selected_card|
        Card.find(selected_card)
      end
      
      cards_to_remove.each do |card|
       if cards["row_one"].any? { |find_card| find_card["id"] == card[:id]}
         if cards["row_one"][0]["id"] == card[:id]
           if cards["row_one"][0]["token"]
             tokens << cards["row_one"][0]["token"]
           end
           cards["row_one"].shift
         elsif cards["row_one"].last["id"] == card[:id]
           if cards["row_one"].last["token"]
             tokens << cards["row_one"].last["token"]
           end
           cards["row_one"].pop
         else
           error = "Invalid selection"
         end
       end
       
       if cards["row_two"].any? { |find_card| find_card["id"] == card[:id]}
         if cards["row_two"][0]["id"] == card[:id]
           if cards["row_two"][0]["token"]
             tokens << cards["row_two"][0]["token"]
           end
           cards["row_two"].shift
         elsif cards["row_two"].last["id"] == card[:id]
           if cards["row_two"].last["token"]
             tokens << cards["row_two"].last["token"]
           end
           cards["row_two"].pop
         else
           error = "Invalid selection"
         end
       end
       
       if cards["row_three"].any? { |find_card| find_card["id"] == card[:id]}
         if cards["row_three"][0]["id"] == card[:id]
           if cards["row_three"][0]["token"]
             tokens << cards["row_three"][0]["token"]
           end
           cards["row_three"].shift
         elsif cards["row_three"].last["id"] == card[:id]
           if cards["row_three"].last["token"]
             tokens << cards["row_three"].last["token"]
           end
           cards["row_three"].pop
         else
           error = "Invalid selection"
         end
       end
       
       if cards["row_four"].any? { |find_card| find_card["id"] == card[:id]}
         if cards["row_four"][0]["id"] == card[:id]
           if cards["row_four"][0]["token"]
             tokens << cards["row_four"][0]["token"]
           end
           cards["row_four"].shift
         elsif cards["row_four"].last["id"] == card[:id]
           if cards["row_four"].last["token"]
             tokens << cards["row_four"].last["token"]
           end
           cards["row_four"].pop
         else
           error = "Invalid selection"
         end
       end
     end
     previously_selected_cards = JSON.parse(current_match.selected_cards)
     all_selected_cards = previously_selected_cards + cards_to_remove
     current_match.selected_cards = all_selected_cards.to_json
     
     previous_tokens = JSON.parse(current_match.tokens)
     tokens.each do |token|
       previous_tokens << token
     end
     current_match.tokens = previous_tokens.to_json
     current_match.save
    else
      error = "It isn't your turn!"
    end
    
    gameState = "play"
    winner = nil
    if cards["row_one"].length + cards["row_two"].length + cards["row_three"].length + cards["row_four"].length == 0
      gameState = "complete"
      game.gamestate = nil
      game.whose_turn_id = nil
      
      score = getScore(user, opponent, game)
      if score["user"]["total"] > score["opponent"]["total"]
        user.wins = user.wins + 1
        opponent.losses = opponent.losses + 1
        user = ranking_change(user, "win")
        opponent = ranking_change(opponent, "loss")
      elsif score["user"]["total"] < score["opponent"]["total"]
        user.losses = user.losses + 1
        opponent.wins = opponent.wins + 1
        user = ranking_change(user, "loss")
        opponent = ranking_change(opponent, "win")
      else
        user.wins = user.wins + 1
        opponent.wins = opponent.wins + 1
        user = ranking_change(user, "win")
        opponent = ranking_change(opponent, "win")
      end
      
      user.save
      opponent.save
      game.winner_id = game.users[0].id
    end
    
    game.gamestate = cards.to_json
    game.whose_turn_id = opponent.id
    opponent = UserSerializer.new(opponent)
    opponent_cards = game.matches.where.not(user: user)[0].selected_cards
    game.save
    render json: {
      gameState: gameState,
      currentUser: user,
      opponent: opponent,
      cards: cards.to_json,
      whose_turn: opponent,
      card_reference: Card.all,
      errorMessage: error,
      winner: winner,
      yourcards: current_match.selected_cards,
      opponentcards: opponent_cards,
      score: score.to_json,
      tokens: current_match.tokens
    }
  end
  
  def getScore(current_player, opponent, current_game)
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
      score["user"][token["spirit"]] += 1
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
      score["opponent"][token["spirit"]] += 1
    end
    
    if score["user"]["branch"] > score["opponent"]["branch"]
      score["user"]["total"] += score["user"]["branch"]
    elsif score["user"]["branch"] < score["opponent"]["branch"]
      score["opponent"]["total"] += score["opponent"]["branch"]
    else
      score["user"]["total"] += score["user"]["branch"]
      score["opponent"]["total"] += score["opponent"]["branch"]
    end
    
    if score["user"]["dew"] > score["opponent"]["dew"]
      score["user"]["total"] += score["user"]["dew"]
    elsif score["user"]["dew"] < score["opponent"]["dew"]
      score["opponent"]["total"] += score["opponent"]["dew"]
    else
      score["user"]["total"] += score["user"]["dew"]
      score["opponent"]["total"] += score["opponent"]["dew"]
    end
    
    if score["user"]["flower"] > score["opponent"]["flower"]
      score["user"]["total"] += score["user"]["flower"]
    elsif score["user"]["flower"] < score["opponent"]["flower"]
      score["opponent"]["total"] += score["opponent"]["flower"]
    else
      score["user"]["total"] += score["user"]["flower"]
      score["opponent"]["total"] += score["opponent"]["flower"]
    end
    
    if score["user"]["fruit"] > score["opponent"]["fruit"]
      score["user"]["total"] += score["user"]["fruit"]
    elsif score["user"]["fruit"] < score["opponent"]["fruit"]
      score["opponent"]["total"] += score["opponent"]["fruit"]
    else
      score["user"]["total"] += score["user"]["fruit"]
      score["opponent"]["total"] += score["opponent"]["fruit"]
    end
    
    if score["user"]["leaf"] > score["opponent"]["leaf"]
      score["user"]["total"] += score["user"]["leaf"]
    elsif score["user"]["leaf"] < score["opponent"]["leaf"]
      score["opponent"]["total"] += score["opponent"]["leaf"]
    else
      score["user"]["total"] += score["user"]["leaf"]
      score["opponent"]["total"] += score["opponent"]["leaf"]
    end
      
    if score["user"]["moss"] > score["opponent"]["moss"]
      score["user"]["total"] += score["user"]["moss"]
    elsif score["user"]["moss"] < score["opponent"]["moss"]
      score["opponent"]["total"] += score["opponent"]["moss"]
    else
      score["user"]["total"] += score["user"]["moss"]
      score["opponent"]["total"] += score["opponent"]["moss"]
    end
    
    if score["user"]["mushroom"] > score["opponent"]["mushroom"]
      score["user"]["total"] += score["user"]["mushroom"]
    elsif score["user"]["mushroom"] < score["opponent"]["mushroom"]
      score["opponent"]["total"] += score["opponent"]["mushroom"]
    else
      score["user"]["total"] += score["user"]["mushroom"]
      score["opponent"]["total"] += score["opponent"]["mushroom"]
    end
    
    if score["user"]["spider"] > score["opponent"]["spider"]
      score["user"]["total"] += score["user"]["spider"]
    elsif score["user"]["spider"] < score["opponent"]["spider"]
      score["opponent"]["total"] += score["opponent"]["spider"]
    else
      score["user"]["total"] += score["user"]["spider"]
      score["opponent"]["total"] += score["opponent"]["spider"]
    end
    
    if score["user"]["vine"] > score["opponent"]["vine"]
      score["user"]["total"] += score["user"]["vine"]
    elsif score["user"]["vine"] < score["opponent"]["vine"]
      score["opponent"]["total"] += score["opponent"]["vine"]
    else
      score["user"]["total"] += score["user"]["vine"]
      score["opponent"]["total"] += score["opponent"]["vine"]
    end
    
    if score["user"]["moon"] > score["opponent"]["moon"]
      score["user"]["total"] += score["user"]["moon"]
    elsif score["user"]["moon"] < score["opponent"]["moon"]
      score["opponent"]["total"] += score["opponent"]["moon"]
    else
      score["user"]["total"] += score["user"]["moon"]
      score["opponent"]["total"] += score["opponent"]["moon"]
    end
    
    if score["user"]["sun"] > score["opponent"]["sun"]
      score["user"]["total"] += score["user"]["sun"]
    elsif score["user"]["sun"] < score["opponent"]["sun"]
      score["opponent"]["total"] += score["opponent"]["sun"]
    else
      score["user"]["total"] += score["user"]["sun"]
      score["opponent"]["total"] += score["opponent"]["sun"]
    end
    
    if score["user"]["wind"] > score["opponent"]["wind"]
      score["user"]["total"] += score["user"]["wind"]
    elsif score["user"]["wind"] < score["opponent"]["wind"]
      score["opponent"]["total"] += score["opponent"]["wind"]
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
  
  def ranking_change(player, game_result)
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
