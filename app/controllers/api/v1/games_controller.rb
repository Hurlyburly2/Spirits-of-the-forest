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
end
