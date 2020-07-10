class GamesController < ApplicationController
  def index
    @games = Game.order(name: :asc)
    render json: @games
  end

  def show
    @game = Game.find_by(id: params[:id])
    render json: @game
  end
end
