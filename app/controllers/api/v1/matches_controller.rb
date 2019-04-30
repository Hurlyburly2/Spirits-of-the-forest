class Api::V1::MatchesController < ApplicationController
  def index
    pending_matches = Match.where.not(user: current_user)
    pending_matches_where_second_player_isnt_user = []
    pending_matches.each do |match|
      game = match.game
      if game.users.include?(current_user) == false && game.users.length < 2
        pending_matches_where_second_player_isnt_user <<  match
      end
    end
    pending_matches_sample =   pending_matches_where_second_player_isnt_user.sample(18)
    
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
