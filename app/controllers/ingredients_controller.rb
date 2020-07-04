class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.where(game_id: params['game_id'])
    render json: @ingredients
  end
end
