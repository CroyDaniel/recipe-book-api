class GamesController < ApplicationController
  def index
    @games = Game.order(name: :asc)
    render json: @games
  end

  def show
    @game = Game.find_by(id: params.require(:id))

    render_not_found_error and return if @game.blank?

    render json: @game
  end
end
