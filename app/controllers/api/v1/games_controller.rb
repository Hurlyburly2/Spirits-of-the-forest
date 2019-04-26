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
end
