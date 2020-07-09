class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.where(game_id: params.dig(:filter, :game_id))
    @ingredients = @ingredients.order(name: :asc)
    @ingredients.includes(:recipe_ingredients)

    render json: @ingredients, include: [:recipe_ingredients]
  end
end
