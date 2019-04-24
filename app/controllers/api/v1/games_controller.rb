class Api::V1::GamesController < ApplicationController
  def index
    render json: current_user.games, each_serializer: GameIndexSerializer
  end
end
