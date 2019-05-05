class Api::V1::GamesController < ApplicationController
  def index
    games = current_user.games
    serialized_games = games.map do |game|
      GameIndexSerializer.new(game)
    end
    render json: {
      currentUser: current_user,
      games: serialized_games
    }
  end
  
  def create
    data = JSON.parse(request.body.read)
    new_game = Game.new
    new_match = Match.new(user: User.find(data["id"]), game: new_game)
    
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
    cards = [].to_json
    
    if (current_game.users.length == 2 && current_game.users.include?(current_user))
      #THIS IS AN IN-PROGRESS GAME
      gameState = "play"
      user = current_user
      opponent = current_game.users.where.not(username: current_user.username)
      opponent = UserSerializer.new(opponent[0])
      cards = Card.get_game_state(current_game)
      whose_turn = UserSerializer.new(User.find(current_game.whose_turn_id))
    elsif (current_game.users.length == 1 && current_game.users[0] == current_user)
      #THIS IS A GAME IN WHICH USER IS WAITING FOR AN OPPONENT
      #THEY SHOULD ONLY HAVE THE OPTION TO DELETE OR GO BACK
      gameState = "pending"
      user = current_user
    elsif (current_game.users.length == 1 && current_game.users[0] != current_user)
      #IF ONE USER AND IT IS NOT CURRENT USER
      #THIS IS A GAME THAT THE USER IS JOINING
      #ADD THE USER TO THE GAME AND CREATE A NEW GAME STATE
      #USER TAKES THE FIRST TURN
      gameState = "play"
      current_game = Game.find(params["id"])
      current_game.whose_turn_id = current_user.id
      new_match = Match.create(game: current_game, user: current_user)
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
      
    render json: {
      gameState: gameState,
      currentUser: user,
      opponent: opponent,
      cards: cards,
      whose_turn: whose_turn,
      card_reference: Card.all
    }
  end
  
  def destroy
    game_to_delete = Game.find(params["id"])
    game_to_delete.destroy
    render json: { response: "ok" }
  end
  
  def update
    user = User.find(params["currentUser"]["id"])
    game = Game.find(params["id"])
    game_state = JSON.parse(game.gamestate)
    selected_cards = params["selected"]
    error = ""
    binding.pry
    
    if game.whose_turn_id == user.id
      cards_to_remove = params["selected"].map do |selected_card|
        Card.find(selected_card)
      end
      
      cards_to_remove.each do |card|
       if game_state["row_three"].any? { |find_card| find_card["id"] == card[:id]}
         if game_state["row_three"][0]["id"] == card[:id]
           game_state["row_three"].shift
         elsif game_state["row_three"].last == card[:id]
           game_state["row_three"].pop
         else
           error = "Invalid selection"
         end
       end
     end
    else
      error = "It isn't your turn!"
    end
   
    render json: { whatever: "test" }
    # game.gamestate = game_state.to_json
    # if game.save
    #   render json: {
    #     gameState: game_state.to_json,
    #     currentUser: user,
    #     opponent: opponent,
    #     cards: cards,
    #     whose_turn: whose_turn,
    #     card_reference: Card.all
    #   }
    # else
    #   render json: {
    #     error = "Something went wrong!"
    #   }
    # end
  end
end
