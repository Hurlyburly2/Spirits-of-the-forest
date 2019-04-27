class Api::V1::MatchesController < ApplicationController
  def index
    pending_matches = Match.where.not(user: current_user)
    pending_matches_sample = pending_matches.sample(18)
    
    serialized_games = pending_matches_sample.map do |match|
      game = match.game
      GameIndexSerializer.new(game)
    end 
    
    current_game_count = current_user.games.length
    
    render json: {
      current_user: current_user,
      current_game_count: current_game_count,
      games: serialized_games
    }
  end
end
