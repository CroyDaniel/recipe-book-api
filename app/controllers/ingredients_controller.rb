class IngredientsController < ApplicationController
  def index
    game_id = params.dig(:filter, :game_id)

    render_blank_game_id_error and return if game_id.blank?

    @ingredients = Ingredient.where(game_id: params.dig(:filter, :game_id))
    @ingredients = @ingredients.order(name: :asc)
    @ingredients.includes(:recipe_ingredients)

    render json: @ingredients, include: [:recipe_ingredients]
  end

  def render_blank_game_id_error
    render json: {
      errors: { detail: 'game_id must be included in filter parameters' }
    }, status: :bad_request
  end
end
