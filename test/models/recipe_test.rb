# == Schema Information
#
# Table name: recipes
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :integer          not null
#
# Indexes
#
#  index_recipes_on_game_id           (game_id)
#  index_recipes_on_name_and_game_id  (name,game_id) UNIQUE
#
require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
