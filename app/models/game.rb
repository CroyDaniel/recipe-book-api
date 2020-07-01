# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_games_on_name  (name) UNIQUE
#
class Game < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_many :recipes
  has_many :ingredients
end
