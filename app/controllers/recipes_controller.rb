class RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(game_id: params.dig(:filter, :game_id))
    @recipes = @recipes.order(name: :asc)
    @recipes.includes(:recipe_ingredients)

    render json: @recipes, include: [:recipe_ingredients]
  end
end
