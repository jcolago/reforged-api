require "test_helper"

class Api::V1::PlayersControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  setup do
    setup_test_data
    @auth_token = login_user(@user)
  end

  test "should get index of all players" do
    get api_v1_players_url, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    players = JSON.parse(response.body)
    assert_equal Player.count, players.length
  end

  test "should get index of players for a specific game" do
    get api_v1_players_url, params: { game_id: @game.id }, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    players = JSON.parse(response.body)
    players.each do |player|
      assert_equal @game.id, player["game_id"]
    end
  end

  test "should show player" do
    get api_v1_player_url(@player), headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    player_response = JSON.parse(response.body)
    assert_equal @player.name, player_response["name"]
    assert_equal @player.character, player_response["character"]
  end

  test "should create player" do
    assert_difference("Player.count") do
      post api_v1_players_url, params: { player: @player_params }, headers: { Authorization: "Bearer #{@auth_token}" }
    end

    assert_response :created
    new_player = JSON.parse(response.body)
    assert_equal @player_params[:name], new_player["name"]
    assert_equal @player_params[:character], new_player["character"]
  end

  test "should not create player with invalid params" do
    assert_no_difference("Player.count") do
      post api_v1_players_url, params: { player: @player_params.merge(name: "") }, headers: { Authorization: "Bearer #{@auth_token}" }
    end

    assert_response :unprocessable_entity
  end

  test "should update player" do
    patch api_v1_player_url(@player), params: { player: { name: "Updated Player" } }, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    @player.reload
    assert_equal "Updated Player", @player.name
  end

  test "should not update player with invalid params" do
    patch api_v1_player_url(@player), params: { player: { name: "" } }, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :unprocessable_entity
  end

  test "should destroy player" do
    assert_difference("Player.count", -1) do
      delete api_v1_player_url(@player), headers: { Authorization: "Bearer #{@auth_token}" }
    end

    assert_response :no_content
  end

  test "should update player's HP" do
    new_hp = 10
    patch update_hp_api_v1_player_url(@player), params: { current_hp: new_hp }, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    @player.reload
    assert_equal new_hp, @player.current_hp
  end

  test "should not update player's HP above total HP" do
    new_hp = @player.total_hp + 1
    patch update_hp_api_v1_player_url(@player), params: { current_hp: new_hp }, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :unprocessable_entity
  end

  test "should calculate ability bonuses on create" do
    post api_v1_players_url, params: { player: @player_params }, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :created
    new_player = JSON.parse(response.body)
    assert_equal 2, new_player["strength_bonus"]
    assert_equal 1, new_player["dexterity_bonus"]
    assert_equal 2, new_player["constitution_bonus"]
    assert_equal 1, new_player["intelligence_bonus"]
    assert_equal 0, new_player["wisdom_bonus"]
    assert_equal 0, new_player["charisma_bonus"]
  end
end