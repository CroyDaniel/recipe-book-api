# == Schema Information
#
# Table name: recipe_ingredients
#
#  id            :integer          not null, primary key
#  count         :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ingredient_id :integer          not null
#  recipe_id     :integer          not null
#
# Indexes
#
#  index_recipe_ingredients_on_ingredient_id  (ingredient_id)
#  index_recipe_ingredients_on_recipe_id      (recipe_id)
#
require 'test_helper'

class RecipeIngredientTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
