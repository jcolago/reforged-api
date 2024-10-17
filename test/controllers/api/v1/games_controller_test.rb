require "test_helper"

class Api::V1::GamesControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  setup do
    setup_test_data
    # @auth_token = login_user(@user)
  end

  test "should get all games" do
    get api_v1_games_url
    assert_response :success
    games = JSON.parse(response.body)
    assert_equal Game.count, games.length
  end

  test "should get games for specific user" do
    get api_v1_games_url, params: { user_id: @user.id }
    assert_response :success
    games = JSON.parse(response.body)
    games.each do |game|
      assert_equal @user.id, game["dm_id"]
    end
  end

  test "should create game" do
    assert_difference("Game.count") do
      post api_v1_games_url, params: { game: { name: "New Game", dm_id: @user.id } }
    end

    assert_response :created
    new_game = JSON.parse(response.body)
    assert_equal "New Game", new_game["name"]
    assert_equal @user.id, new_game["dm_id"]
  end

  test "should show game" do
    get api_v1_game_url(@game)
    assert_response :success
    game_response = JSON.parse(response.body)
    assert_equal @game.name, game_response["name"]
  end

  test "should update game" do
    patch api_v1_game_url(@game), params: { game: { name: "Updated Game" } }
    assert_response :success
    @game.reload
    assert_equal "Updated Game", @game.name
  end

  test "should destroy game" do
    assert_difference("Game.count", -1) do
      delete api_v1_game_url(@game)
    end

    assert_response :no_content
  end

  test "should destroy game and associated monsters" do
    game = games(:game_one)
    monster_count = game.monsters.count

    assert_difference("Game.count", -1) do
      assert_difference("Monster.count", -monster_count) do
        delete api_v1_game_url(game)
      end
    end

    assert_response :no_content
    assert_equal 0, Monster.where(game_id: game.id).count
  end

  test "should not create game with invalid params" do
    assert_no_difference("Game.count") do
      post api_v1_games_url, params: { game: { name: "", dm_id: @user.id } }
    end

    assert_response :unprocessable_entity
  end

  test "should not update game with invalid params" do
    patch api_v1_game_url(@game), params: { game: { name: "" } }
    assert_response :unprocessable_entity
  end
end
