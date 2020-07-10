require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test 'index returns all games when games exist' do
    game = Game.create(name: 'Game 1')

    get '/games'
    parsed_body = JSON.parse(response.body)
    game_ids = parsed_body['data']&.map { |data| data['id'] }

    assert_response :success
    assert_equal(game_ids, [game.id.to_s])

    game2 = Game.create(name: 'Game 2')

    get '/games'
    parsed_body = JSON.parse(response.body)
    game_ids = parsed_body['data']&.map { |data| data['id'] }

    assert_response :success
    assert_equal(game_ids, [game.id.to_s, game2.id.to_s])
  end

  test 'index returns nothing when games do not exist' do
    get '/games'
    parsed_body = JSON.parse(response.body)

    assert_response :success
    assert_equal(parsed_body['data'], [])
  end

  test 'index returns games in name asc order' do
    game = Game.create(name: 'A')
    game2 = Game.create(name: 'B')

    get '/games'
    parsed_body = JSON.parse(response.body)
    game_ids = parsed_body['data']&.map { |data| data['id'] }

    assert_response :success
    assert_equal(game_ids, [game.id.to_s, game2.id.to_s])

    game.update(name: 'C')

    get '/games'
    parsed_body = JSON.parse(response.body)
    game_ids = parsed_body['data']&.map { |data| data['id'] }

    assert_response :success
    assert_equal(game_ids, [game2.id.to_s, game.id.to_s])
  end

  test 'show returns game when game exists' do
    game = Game.create(name: 'Game 1')

    get "/games/#{game.id}"
    parsed_body = JSON.parse(response.body)
    game_id = parsed_body.dig('data', 'id')

    assert_response :success
    assert_equal(game_id, game.id.to_s)
  end

  test 'show returns error when game does not exist' do
    get '/games/1'
    parsed_body = JSON.parse(response.body)

    assert_response :not_found
    assert_equal(parsed_body.dig('errors', 'detail'), 'resource not found')
  end
end
