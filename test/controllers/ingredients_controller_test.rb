require 'test_helper'

class IngredientsControllerTest < ActionDispatch::IntegrationTest
  test 'index returns error when game_id is not specified' do
    get '/ingredients'
    parsed_body = JSON.parse(response.body)

    assert_response :bad_request
    assert_equal(parsed_body['errors']['detail'], 'game_id must be included in filter parameters')
  end

  test 'index returns ingredients when game_id is specified and ingredients exist' do
    game = Game.create(name: 'Game 1')
    ingredient = Ingredient.create(name: 'Ingredient 1', game_id: game.id)

    get '/ingredients', **{
      params: { filter: { game_id: game.id } }
    }
    parsed_body = JSON.parse(response.body)
    ingredient_ids = parsed_body['data']&.map { |data| data['id'] }

    assert_response :success
    assert_equal(ingredient_ids, [ingredient.id.to_s])
  end

  test 'index returns nothing when game_id is specified and ingredients do not exist' do
    game = Game.create(name: 'Game 1')

    get '/ingredients', **{
      params: { filter: { game_id: game.id } }
    }
    parsed_body = JSON.parse(response.body)

    assert_response :success
    assert_equal(parsed_body['data'], [])
  end

  test 'index returns ingredients in name asc order' do
    game = Game.create(name: 'Game 1')
    ingredient = Ingredient.create(name: 'A', game_id: game.id)
    ingredient2 = Ingredient.create(name: 'B', game_id: game.id)

    get '/ingredients', **{
      params: { filter: { game_id: game.id } }
    }
    parsed_body = JSON.parse(response.body)
    ingredient_ids = parsed_body['data']&.map { |data| data['id'] }

    assert_response :success
    assert_equal(ingredient_ids, [ingredient.id.to_s, ingredient2.id.to_s])

    ingredient.update(name: 'C')

    get '/ingredients', **{
      params: { filter: { game_id: game.id } }
    }
    parsed_body = JSON.parse(response.body)
    ingredient_ids = parsed_body['data']&.map { |data| data['id'] }

    assert_response :success
    assert_equal(ingredient_ids, [ingredient2.id.to_s, ingredient.id.to_s])
  end
end
