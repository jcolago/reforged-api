require "test_helper"

class Api::V1::PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = players(:joe)
    @game = games(:game_one)
    @player_params = {
      name: "New Player",
      character: "New Character",
      image: "new-url-here",
      level: 2,
      current_hp: 15,
      total_hp: 20,
      armor_class: 16,
      speed: 30,
      initiative_bonus: 2,
      strength: 14,
      str_save: 2,
      dexterity: 13,
      dex_save: 1,
      constitution: 15,
      con_save: 2,
      intelligence: 12,
      int_save: 1,
      wisdom: 10,
      wis_save: 0,
      charisma: 11,
      cha_save: 0,
      displayed: true,
      game_id: @game.id
    }
  end

  test "should get index" do
    get api_v1_players_url
    assert_response :success
    players = JSON.parse(response.body)
    assert_equal Player.count, players.length
  end

  test "should show player" do
    get api_v1_player_url(@player)
    assert_response :success
    player_response = JSON.parse(response.body)
    assert_equal @player.name, player_response["name"]
    assert_equal @player.character, player_response["character"]
  end

  test "should create player" do
    assert_difference("Player.count") do
      post api_v1_players_url, params: { player: @player_params }
    end

    assert_response :created
    new_player = JSON.parse(response.body)
    assert_equal @player_params[:name], new_player["name"]
    assert_equal @player_params[:character], new_player["character"]
  end

  test "should not create player with invalid params" do
    assert_no_difference("Player.count") do
      post api_v1_players_url, params: { player: @player_params.merge(name: "") }
    end

    assert_response :unprocessable_entity
  end

  test "should update player" do
    patch api_v1_player_url(@player), params: { player: { name: "Updated Player" } }
    assert_response :success
    @player.reload
    assert_equal "Updated Player", @player.name
  end

  test "should not update player with invalid params" do
    patch api_v1_player_url(@player), params: { player: { name: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy player" do
    assert_difference("Player.count", -1) do
      delete api_v1_player_url(@player)
    end

    assert_response :no_content
  end

  test "should update player's HP" do
    new_hp = 10
    patch update_hp_api_v1_player_url(@player), params: { current_hp: new_hp }
    assert_response :success
    @player.reload
    assert_equal new_hp, @player.current_hp
  end

  test "should not update player's HP above total HP" do
    new_hp = @player.total_hp + 1
    patch update_hp_api_v1_player_url(@player), params: { current_hp: new_hp }
    assert_response :unprocessable_entity
  end

  test "should calculate ability bonuses on create" do
    post api_v1_players_url, params: { player: @player_params }
    assert_response :created
    new_player = JSON.parse(response.body)
    assert_equal 2, new_player["str_bonus"]
    assert_equal 1, new_player["dex_bonus"]
    assert_equal 2, new_player["con_bonus"]
    assert_equal 1, new_player["int_bonus"]
    assert_equal 0, new_player["wis_bonus"]
    assert_equal 0, new_player["cha_bonus"]
  end
end
