class RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(game_id: params['game_id'])
    render json: @recipes
  end
end
