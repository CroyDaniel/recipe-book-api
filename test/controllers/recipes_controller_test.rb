require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  test 'index returns error when game_id is not specified' do
    get '/recipes'
    parsed_body = JSON.parse(response.body)

    assert_response :bad_request
    assert_equal(parsed_body.dig('errors', 'detail'), 'game_id must be included in filter parameters')
  end

  test 'index returns recipes when game_id is specified and recipes exist' do
    game = Game.create(name: 'Game 1')
    recipe = Recipe.create(name: 'Recipe 1', game_id: game.id)

    get '/recipes', params: { filter: { game_id: game.id } }
    parsed_body = JSON.parse(response.body)
    recipe_ids = parsed_body['data']&.map { |data| data['id'] }

    assert_response :success
    assert_equal(recipe_ids, [recipe.id.to_s])
  end

  test 'index returns nothing when game_id is specified and recipes do not exist' do
    game = Game.create(name: 'Game 1')

    get '/recipes', params: { filter: { game_id: game.id } }
    parsed_body = JSON.parse(response.body)

    assert_response :success
    assert_equal(parsed_body['data'], [])
  end

  test 'index returns recipes in name asc order' do
    game = Game.create(name: 'Game 1')
    recipe = Recipe.create(name: 'A', game_id: game.id)
    recipe2 = Recipe.create(name: 'B', game_id: game.id)

    get '/recipes', params: { filter: { game_id: game.id } }
    parsed_body = JSON.parse(response.body)
    recipe_ids = parsed_body['data']&.map { |data| data['id'] }

    assert_response :success
    assert_equal(recipe_ids, [recipe.id.to_s, recipe2.id.to_s])

    recipe.update(name: 'C')

    get '/recipes', params: { filter: { game_id: game.id } }
    parsed_body = JSON.parse(response.body)
    recipe_ids = parsed_body['data']&.map { |data| data['id'] }

    assert_response :success
    assert_equal(recipe_ids, [recipe2.id.to_s, recipe.id.to_s])
  end
end
