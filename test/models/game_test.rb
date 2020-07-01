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
require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
