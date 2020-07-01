# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  game_id    :integer          not null
#
# Indexes
#
#  index_ingredients_on_game_id           (game_id)
#  index_ingredients_on_name_and_game_id  (name,game_id) UNIQUE
#
class Ingredient < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :game_id }
  validates :game_id, presence: true

  belongs_to :game

  has_many :recipe_ingredients, dependent: :destroy

  has_many :recipes, through: :recipe_ingredients
end
