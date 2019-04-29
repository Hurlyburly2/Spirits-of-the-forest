class Api::V1::GamesController < ApplicationController
  def index
    games = current_user.games
    serialized_games = games.map do |game|
      GameIndexSerializer.new(game)
    end
    
    render json: {
      current_user: current_user,
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
    
    if (current_game.users.length == 2 && current_game.users.include?(current_user))
      #IF ALREADY TWO USERS AND ONE IS CURRENT USER
      #THIS IS AN IN-PROGRESS GAME
    elsif (current_game.users.length == 1 && current_game.users[0] == current_user)
      gameState = "pending"
      user = current_user
      #THIS IS A GAME IN WHICH USER IS WAITING FOR AN OPPONENT
      #THEY SHOULD ONLY HAVE THE OPTION TO DELETE OR GO BACK
      #A FACE-DOWN DECK OF CARDS SHOULD DISPLAY AS IF READY FOR SETUP
    elsif (current_game.users.length == 1 && current_game.users[0] != current_user)
      current_game = Game.find(params["id"])
      new_match = Match.create(game: current_game, user: current_user)
      user = current_user
      opponent = current_game.users.where.not(user: current_user)

      #IF ONE USER AND IT IS NOT CURRENT USER
      #THIS IS A GAME THAT THE USER IS JOINING
      #ADD THE USER TO THE GAME AND CREATE A NEW GAME STATE
      #USER TAKES THE FIRST TURN
    else
      #ELSE ALREADY TWO USERS AND NEITHER ARE CURRENT USER OR NO USERS
      #THIS GAME NO LONGER EXISTS ERROR
    end
      
    render json: {
      gameState: gameState,
      currentUser: user,
      opponent: opponent
    }
  end
end
