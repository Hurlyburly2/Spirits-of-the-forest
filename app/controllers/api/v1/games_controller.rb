class Api::V1::GamesController < ApplicationController
  def index
    serialized_games = Game.get_games_list(current_user)
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
    your_gems = 0
    your_total_gems = 0
    opponent_gems = 0
    opponent_total_gems = 0
    if (current_game.users.length == 2 && current_game.users.include?(current_user))
      #THIS IS AN IN-PROGRESS GAME OR A COMPLETED/CONCEDED GAME
      if current_game.winner_id == nil
        gameState = "play"
        user = current_user
        opponent = current_game.users.where.not(username: current_user.username)
        score = Game.getScore(user, opponent[0], current_game)
        opponent = UserSerializer.new(opponent[0])
        cards = Card.get_game_state(current_game)
        your_tokens = current_game.matches.where(user: current_user)[0].tokens
        your_gems = current_game.matches.where(user: current_user)[0].gems_possessed
        your_total_gems = current_game.matches.where(user: current_user)[0].gems_total
        opponent_tokens = current_game.matches.where.not(user: current_user)[0].tokens
        opponent_gems = current_game.matches.where.not(user: current_user)[0].gems_possessed
        opponent_total_gems = current_game.matches.where.not(user: current_user)[0].gems_total
        whose_turn = UserSerializer.new(User.find(current_game.whose_turn_id))
      else
        gameState = "complete"
        user = current_user
        opponent = current_game.users.where.not(username: current_user.username)
        score = Game.getScore(user, opponent[0], current_game)
        opponent = UserSerializer.new(opponent[0])
        cards = nil
        whose_turn = nil
        your_tokens = current_game.matches.where(user: current_user)[0].tokens
        your_gems = current_game.matches.where(user: current_user)[0].gems_possessed
        your_total_gems = current_game.matches.where(user: current_user)[0].gems_total
        opponent_tokens = current_game.matches.where.not(user: current_user)[0].tokens
        opponent_gems = current_game.matches.where.not(user: current_user)[0].gems_possessed
        opponent_total_gems = current_game.matches.where.not(user: current_user)[0].gems_total
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
      your_gems = current_game.matches.where(user: current_user)[0].gems_possessed
      your_total_gems = current_game.matches.where(user: current_user)[0].gems_total
      opponent_gems = current_game.matches.where.not(user: current_user)[0].gems_possessed
      opponent_total_gems = current_game.matches.where.not(user: current_user)[0].gems_total
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
      yourGems: your_gems,
      yourTotalGems: your_total_gems,
      opponentTokens: opponent_tokens,
      opponentGems: opponent_gems,
      opponentTotalGems: opponent_total_gems,
      gemPlaced: current_game.gem_placed
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
      winner = User.ranking_change(winner, "win")
      loser = User.ranking_change(loser, "loss")
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
    if params["type"] == "card-selection"
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
          cards, tokens = Game.remove_cards_from_row(card, "row_one", cards, current_match, tokens)
          cards, tokens = Game.remove_cards_from_row(card, "row_two", cards, current_match, tokens)
          cards, tokens = Game.remove_cards_from_row(card, "row_three", cards, current_match, tokens)
          cards, tokens = Game.remove_cards_from_row(card, "row_four", cards, current_match, tokens)
       end
       
       game.gamestate = cards.to_json
       
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
      
      all_rows = JSON.parse(game.gamestate)
      all_cards = all_rows["row_one"] + all_rows["row_two"] + all_rows["row_three"] + all_rows["row_four"]
      opponent_has_valid_moves = false
      
      opponent_match = game.matches.where(user: opponent)[0]
      
      if opponent_match.gems_total < 1
        opponent_has_valid_moves = false
      else
        opponent_has_valid_moves = true
      end
      
      bad_row_count = 0 #IF THIS EQUAL FOUR, INVALID MOVE FOR OPPONENT'
      all_rows.each do |row|
        valid_moves_in_row = true
        if row[1].length == 0
          valid_moves_in_row = false
        else
          first_valid = true
          last_valid = true
          if row[1].first["gem"] && row[1].first["gem"]["id"] != opponent.id
            first_valid = false
          end
          if row[1].last["gem"] && row[1].last["gem"]["id"] != opponent.id
            last_valid = false
          end
          if first_valid == false && last_valid == false
            valid_moves_in_row = false
          end
        end
        if valid_moves_in_row == false
          bad_row_count += 1
        end
      end
      
      if bad_row_count < 4
        opponent_has_valid_moves = true
      end
      #Check for available moves before switching turns
      if opponent_has_valid_moves == true
        game.whose_turn_id = opponent.id
      end
      
      if cards["row_one"].length + cards["row_two"].length + cards["row_three"].length + cards["row_four"].length == 0
        gameState = "complete"
        game.gamestate = nil
        game.whose_turn_id = nil
        
        score = Game.getScore(user, opponent, game)
        if score["user"]["total"] > score["opponent"]["total"]
          user.wins = user.wins + 1
          opponent.losses = opponent.losses + 1
          user = User.ranking_change(user, "win")
          opponent = User.ranking_change(opponent, "loss")
        elsif score["user"]["total"] < score["opponent"]["total"]
          user.losses = user.losses + 1
          opponent.wins = opponent.wins + 1
          user = User.ranking_change(user, "loss")
          opponent = User.ranking_change(opponent, "win")
        else
          user.wins = user.wins + 1
          opponent.wins = opponent.wins + 1
          user = User.ranking_change(user, "win")
          opponent = User.ranking_change(opponent, "win")
        end
        
        user.save
        opponent.save
        game.winner_id = game.users[0].id
      end
      
      
      game.gem_placed = false
      next_turn = ""
      if game.whose_turn_id == opponent.id
        next_turn = UserSerializer.new(opponent)
      else
        next_turn = UserSerializer.new(user)
      end
      
      opponent_cards = game.matches.where.not(user: user)[0].selected_cards
      game.save
      render json: {
        gameState: gameState,
        currentUser: user,
        opponent: opponent,
        cards: cards.to_json,
        whose_turn: next_turn,
        card_reference: Card.all,
        errorMessage: error,
        winner: winner,
        yourcards: current_match.selected_cards,
        opponentcards: opponent_cards,
        score: score.to_json,
        tokens: current_match.tokens,
        gemPlaced: game.gem_placed,
        yourGems: current_match.gems_possessed
      }
    elsif params["type"] == "gem-placement"
      current_game = Game.find(params["currentGame"])
      current_game_gameState = JSON.parse(current_game.gamestate)
      user = User.find(params["currentUser"]["id"])
      current_match = current_game.matches.where(user: user)[0]
      opponent_match = current_game.matches.where.not(user: user)[0]
      error_message = ""
      
      if current_game_gameState["row_one"].any? { |card| card["id"] == params["gemmedCard"] }
        current_game_gameState, error_message = Game.gem_placement("row_one", current_game_gameState, params["gemmedCard"], user, current_match, current_game, opponent_match, error_message, params["currentUser"]["id"], params["currentUser"]["username"])
      elsif current_game_gameState["row_two"].any? { |card| card["id"] == params["gemmedCard"] }
        current_game_gameState, error_message = Game.gem_placement("row_two", current_game_gameState, params["gemmedCard"], user, current_match, current_game, opponent_match, error_message, params["currentUser"]["id"], params["currentUser"]["username"])
      elsif current_game_gameState["row_three"].any? { |card| card["id"] == params["gemmedCard"] }
        current_game_gameState, error_message = Game.gem_placement("row_three", current_game_gameState, params["gemmedCard"], user, current_match, current_game, opponent_match, error_message, params["currentUser"]["id"], params["currentUser"]["username"])
      elsif current_game_gameState["row_four"].any? { |card| card["id"] == params["gemmedCard"] }
          current_game_gameState, error_message = Game.gem_placement("row_four", current_game_gameState, params["gemmedCard"], user, current_match, current_game, opponent_match, error_message, params["currentUser"]["id"], params["currentUser"]["username"])
      end
      
      current_game.gamestate = current_game_gameState.to_json
      current_game.save
      
      render json: {
        cards: current_game_gameState.to_json,
        yourGems: current_match.gems_possessed,
        yourTotalGems: current_match.gems_total,
        opponentGems: opponent_match.gems_possessed,
        errorMessage: error_message,
        gemPlaced: current_game.gem_placed
      }
    end
  end
end
