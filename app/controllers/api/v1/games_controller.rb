class Api::V1::GamesController < ApplicationController
  def index
    Appstamp.check_for_inactive_games
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
        score = getScore(user, opponent[0], current_game)
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
        score = getScore(user, opponent[0], current_game)
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
         if cards["row_one"].any? { |find_card| find_card["id"] == card[:id]}
           if cards["row_one"][0]["id"] == card[:id]
             if cards["row_one"][0]["token"]
               if cards["row_one"][0]["token"]["spirit"] == "plus-1" || cards["row_one"][0]["token"]["spirit"] == "plus-2"
                 current_match.gems_possessed += 1
                 current_match.gems_total += 1
                 current_match.save
               end
               tokens << cards["row_one"][0]["token"]
             end
             if cards["row_one"][0]["gem"]
               current_match.gems_possessed += 1
               current_match.save
             end
             cards["row_one"].shift
           elsif cards["row_one"].last["id"] == card[:id]
             if cards["row_one"].last["token"]
               if cards["row_one"].last["token"]["spirit"] == "plus-1" || cards["row_one"].last["token"]["spirit"] == "plus-2"
                 current_match.gems_possessed += 1
                 current_match.gems_total += 1
                 current_match.save
               end
               tokens << cards["row_one"].last["token"]
             end
             if cards["row_one"].last["gem"]
               current_match.gems_possessed += 1
               current_match.save
             end
             cards["row_one"].pop
           else
             error = "Invalid selection"
           end
         end
         
         if cards["row_two"].any? { |find_card| find_card["id"] == card[:id]}
           if cards["row_two"][0]["id"] == card[:id]
             if cards["row_two"][0]["token"]
               if cards["row_two"][0]["token"]["spirit"] == "plus-1" || cards["row_two"][0]["token"]["spirit"] == "plus-2"
                 current_match.gems_possessed += 1
                 current_match.gems_total += 1
                 current_match.save
               end
               tokens << cards["row_two"][0]["token"]
             end
             if cards["row_two"][0]["gem"]
               current_match.gems_possessed += 1
               current_match.save
             end
             cards["row_two"].shift
           elsif cards["row_two"].last["id"] == card[:id]
             if cards["row_two"].last["token"]
               if cards["row_two"].last["token"]["spirit"] == "plus-1" || cards["row_two"].last["token"]["spirit"] == "plus-2"
                 current_match.gems_possessed += 1
                 current_match.gems_total += 1
                 current_match.save
               end
               tokens << cards["row_two"].last["token"]
             end
             if cards["row_two"].last["gem"]
               current_match.gems_possessed += 1
               current_match.save
             end
             cards["row_two"].pop
           else
             error = "Invalid selection"
           end
         end
         
         if cards["row_three"].any? { |find_card| find_card["id"] == card[:id]}
           if cards["row_three"][0]["id"] == card[:id]
             if cards["row_three"][0]["token"]
               if cards["row_three"][0]["token"]["spirit"] == "plus-1" || cards["row_three"][0]["token"]["spirit"] == "plus-2"
                 current_match.gems_possessed += 1
                 current_match.gems_total += 1
                 current_match.save
               end
               tokens << cards["row_three"][0]["token"]
             end
             if cards["row_three"][0]["gem"]
               current_match.gems_possessed += 1
               current_match.save
             end
             cards["row_three"].shift
           elsif cards["row_three"].last["id"] == card[:id]
             if cards["row_three"].last["token"]
               if cards["row_three"].last["token"]["spirit"] == "plus-1" || cards["row_three"].last["token"]["spirit"] == "plus-2"
                 current_match.gems_possessed += 1
                 current_match.gems_total += 1
                 current_match.save
               end
               tokens << cards["row_three"].last["token"]
             end
             if cards["row_three"].last["gem"]
               current_match.gems_possessed += 1
               current_match.save
             end
             cards["row_three"].pop
           else
             error = "Invalid selection"
           end
         end
         
         if cards["row_four"].any? { |find_card| find_card["id"] == card[:id]}
           if cards["row_four"][0]["id"] == card[:id]
             if cards["row_four"][0]["token"]
               if cards["row_four"][0]["token"]["spirit"] == "plus-1" || cards["row_four"][0]["token"]["spirit"] == "plus-2"
                 current_match.gems_possessed += 1
                 current_match.gems_total += 1
                 current_match.save
               end
               tokens << cards["row_four"][0]["token"]
             end
             if cards["row_four"][0]["gem"]
               current_match.gems_possessed += 1
               current_match.save
             end
             cards["row_four"].shift
           elsif cards["row_four"].last["id"] == card[:id]
             if cards["row_four"].last["token"]
               if cards["row_four"].last["token"]["spirit"] == "plus-1" || cards["row_four"].last["token"]["spirit"] == "plus-2"
                 current_match.gems_possessed += 1
                 current_match.gems_total += 1
                 current_match.save
               end
               tokens << cards["row_four"].last["token"]
             end
             if cards["row_four"].last["gem"]
               current_match.gems_possessed += 1
               current_match.save
             end
             cards["row_four"].pop
           else
             error = "Invalid selection"
           end
         end
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
      
      # all_cards.each do |card|
      #   if card["gem"]
      #     if card["gem"]["id"] == opponent.id
      #       opponent_has_valid_moves = true
      #     end
      #   else
      #     opponent_has_valid_moves = true
      #   end
      # end
      # OLD CHECKER (DOESN'T WORK IN EDGE CASES?)
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
        
        score = getScore(user, opponent, game)
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
        card_to_gem_index = current_game_gameState["row_one"].index{ |card| card["id"] == params["gemmedCard"] }
        if current_game_gameState["row_one"][card_to_gem_index]["gem"] #IF THE CARD HAS A GEM
          if current_game_gameState["row_one"][card_to_gem_index]["gem"]["id"] == user.id
            current_game_gameState["row_one"][card_to_gem_index].delete("gem")
            current_match.gems_possessed += 1
            current_match.save
          else
            #OPPONENT GEM LOGIC
            if current_match.gems_possessed > 0 && current_game.gem_placed == false
              current_game_gameState["row_one"][card_to_gem_index].delete("gem")
              current_game.gem_placed = true
              current_game.save
              current_match.gems_possessed -= 1
              current_match.gems_total -= 1
              current_match.save
              opponent_match.gems_possessed += 1
              opponent_match.save
            elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
              error_message = "You have already placed a gem this turn"
            else
              error_message = "You need to be holding a gem in order to remove your opponent's"
            end
          end
        else #IF THE CARD DOES NOT HAVE A GEM
          if current_match.gems_possessed > 0 && current_game.gem_placed == false
            card_to_gem_index = current_game_gameState["row_one"].index{ |card| card["id"] == params["gemmedCard"] }
            current_game_gameState["row_one"][card_to_gem_index]["gem"] = {"id" => params["currentUser"]["id"], "username" => params["currentUser"]["username"] }
            current_game.gem_placed = true
            current_game.save
            current_match.gems_possessed -= 1
            current_match.save
          elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
            error_message = "You have already placed a gem this turn"
          else
            error_message = "You don't have any gems left to place!"
          end
        end
        
      elsif current_game_gameState["row_two"].any? { |card| card["id"] == params["gemmedCard"] }
        card_to_gem_index = current_game_gameState["row_two"].index{ |card| card["id"] == params["gemmedCard"] }
        if current_game_gameState["row_two"][card_to_gem_index]["gem"] #IF THE CARD HAS A GEM
          if current_game_gameState["row_two"][card_to_gem_index]["gem"]["id"] == user.id
            current_game_gameState["row_two"][card_to_gem_index].delete("gem")
            current_match.gems_possessed += 1
            current_match.save
          else
            #OPPONENT GEM LOGIC
            if current_match.gems_possessed > 0 && current_game.gem_placed == false
              current_game_gameState["row_two"][card_to_gem_index].delete("gem")
              current_game.gem_placed = true
              current_game.save
              current_match.gems_possessed -= 1
              current_match.gems_total -= 1
              current_match.save
              opponent_match.gems_possessed += 1
              opponent_match.save
            elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
              error_message = "You have already placed a gem this turn"
            else
              error_message = "You need to be holding a gem in order to remove your opponent's"
            end
          end
        else #IF THE CARD DOES NOT HAVE A GEM
          if current_match.gems_possessed > 0 && current_game.gem_placed == false
            card_to_gem_index = current_game_gameState["row_two"].index{ |card| card["id"] == params["gemmedCard"] }
            current_game_gameState["row_two"][card_to_gem_index]["gem"] = {"id" => params["currentUser"]["id"], "username" => params["currentUser"]["username"] }
            current_game.gem_placed = true
            current_game.save
            current_match.gems_possessed -= 1
            current_match.save
          elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
            error_message = "You have already placed a gem this turn"
          else
            error_message = "You don't have any gems left to place!"
          end
        end
        
      elsif current_game_gameState["row_three"].any? { |card| card["id"] == params["gemmedCard"] }
        card_to_gem_index = current_game_gameState["row_three"].index{ |card| card["id"] == params["gemmedCard"] }
        if current_game_gameState["row_three"][card_to_gem_index]["gem"] #IF THE CARD HAS A GEM
          if current_game_gameState["row_three"][card_to_gem_index]["gem"]["id"] == user.id
            current_game_gameState["row_three"][card_to_gem_index].delete("gem")
            current_match.gems_possessed += 1
            current_match.save
          else
            #OPPONENT GEM LOGIC
            if current_match.gems_possessed > 0 && current_game.gem_placed == false
              current_game_gameState["row_three"][card_to_gem_index].delete("gem")
              current_game.gem_placed = true
              current_game.save
              current_match.gems_possessed -= 1
              current_match.gems_total -= 1
              current_match.save
              opponent_match.gems_possessed += 1
              opponent_match.save
            elsif current_match.gems_possessed && current_game.gem_placed == true
              error_message = "You have already placed a gem this turn"
            else
              error_message = "You need to be holding a gem in order to remove your opponent's"
            end
          end
        else #IF THE CARD DOES NOT HAVE A GEM
          if current_match.gems_possessed > 0 && current_game.gem_placed == false
            card_to_gem_index = current_game_gameState["row_three"].index{ |card| card["id"] == params["gemmedCard"] }
            current_game_gameState["row_three"][card_to_gem_index]["gem"] = {"id" => params["currentUser"]["id"], "username" => params["currentUser"]["username"] }
            current_game.gem_placed = true
            current_game.save
            current_match.gems_possessed -= 1
            current_match.save
          elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
            error_message = "You have already placed a gem this turn"
          else
            error_message = "You don't have any gems left to place!"
          end
        end
        
      elsif current_game_gameState["row_four"].any? { |card| card["id"] == params["gemmedCard"] }
        card_to_gem_index = current_game_gameState["row_four"].index{ |card| card["id"] == params["gemmedCard"] }
        if current_game_gameState["row_four"][card_to_gem_index]["gem"] #IF THE CARD HAS A GEM
          if current_game_gameState["row_four"][card_to_gem_index]["gem"]["id"] == user.id
            current_game_gameState["row_four"][card_to_gem_index].delete("gem")
            current_match.gems_possessed += 1
            current_match.save
          else
            #OPPONENT GEM LOGIC
            if current_match.gems_possessed > 0 && current_game.gem_placed == false
              current_game_gameState["row_four"][card_to_gem_index].delete("gem")
              current_game.gem_placed = true
              current_game.save
              current_match.gems_possessed -= 1
              current_match.gems_total -= 1
              current_match.save
              opponent_match.gems_possessed += 1
              opponent_match.save
            elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
              error_message = "You have already placed a gem this turn"
            else
              error_message = "You need to be holding a gem in order to remove your opponent's"
            end
          end
        else #IF THE CARD DOES NOT HAVE A GEM
          if current_match.gems_possessed > 0 && current_game.gem_placed == false
            card_to_gem_index = current_game_gameState["row_four"].index{ |card| card["id"] == params["gemmedCard"] }
            current_game_gameState["row_four"][card_to_gem_index]["gem"] = {"id" => params["currentUser"]["id"], "username" => params["currentUser"]["username"] }
            current_game.gem_placed = true
            current_game.save
            current_match.gems_possessed -= 1
            current_match.save
          elsif current_match.gems_possessed > 0 && current_game.gem_placed == true
            error_message = "You have already placed a gem this turn"
          else
            error_message = "You don't have any gems left to place!"
          end
        end
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
  
  # def ranking_change(player, game_result)
  #   if player.rank == "bronze"
  #     if game_result == "loss"
  #       player.rankup_score = player.rankup_score - 3
  #       if player.rankup_score < 0
  #         player.rankup_score = 0
  #       end
  #     else
  #       player.rankup_score = player.rankup_score + 10
  #     end
  #   elsif player.rank == "silver"
  #     if game_result == "loss"
  #       player.rankup_score = player.rankup_score - 4
  #     else
  #       player.rankup_score = player.rankup_score + 10
  #     end
  #   elsif player.rank == "gold"
  #     if game_result == "loss"
  #       player.rankup_score = player.rankup_score - 5
  #     else
  #       player.rankup_score = player.rankup_score + 10
  #     end
  #   elsif player.rank == "diamond"
  #     if game_result == "loss"
  #       player.rankup_score = player.rankup_score - 7
  #     else
  #       player.rankup_score = player.rankup_score + 10
  #     end
  #   else
  #     if game_result == "loss"
  #       player.rankup_score = player.rankup_score - 9
  #     else
  #       player.rankup_score = player.rankup_score + 10
  #     end
  #   end
  # 
  #   if player.rankup_score >= 0 && player.rankup_score < 100
  #     player.rank = "bronze"
  #   elsif player.rankup_score >= 100 && player.rankup_score < 200
  #     player.rank = "silver"
  #   elsif player.rankup_score >= 200 && player.rankup_score < 300
  #     player.rank = "gold"
  #   elsif player.rankup_score >= 300 && player.rankup_score < 400
  #     player.rank = "diamond"
  #   else
  #     player.rank = "master"
  #   end
  #   player.save
  #   player
  # end
end
