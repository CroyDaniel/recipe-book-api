class RecipesController < ApplicationController
  def index
    game_id = params.dig(:filter, :game_id)

    render_blank_game_id_error and return if game_id.blank?

    @recipes = Recipe.where(game_id: params.dig(:filter, :game_id))
    @recipes = @recipes.order(name: :asc)
    @recipes.includes(:recipe_ingredients)

    render json: @recipes, include: [:recipe_ingredients]
  end

  def render_blank_game_id_error
    render json: {
      errors: { detail: 'game_id must be included in filter parameters' }
    }, status: :bad_request
  end
end
