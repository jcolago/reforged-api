require "test_helper"

class Api::V1::MonstersControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  setup do
    setup_test_data
    # @auth_token = login_user(@user)
  end

  test "should get index of all monsters" do
    get api_v1_monsters_url
    assert_response :success
    monsters = JSON.parse(response.body)
    assert_equal Monster.count, monsters.length
  end

  test "Should get index of monsters for a specific game" do
    get api_v1_monsters_url, params: { game_id: @game.id }
    assert_response :success
    monsters = JSON.parse(response.body)
    monsters.each do |monster|
      assert_equal @game.id, monster["game_id"]
    end
  end

  test "should show monster" do
    get api_v1_monster_url(@monster)
    assert_response :success
    monster_response = JSON.parse(response.body)
    assert_equal @monster.name, monster_response["name"]
  end

  test "should create monster" do
    assert_difference("Monster.count") do
      post api_v1_monsters_url, params: { monster: @monster_params }
    end

    assert_response :created
    new_monster = JSON.parse(response.body)
    assert_equal @monster_params[:name], new_monster["name"]
    assert_equal @monster_params[:size].to_s, new_monster["size"]
    assert_equal @monster_params[:alignment].to_s, new_monster["alignment"]
  end


  test "should not create monster with invalid params" do
    assert_no_difference("Monster.count") do
      post api_v1_monsters_url, params: { monster: @monster_params.merge(name: "") }
    end

    assert_response :unprocessable_entity
  end

  test "should update monster" do
    patch api_v1_monster_url(@monster), params: { monster: { name: "Updated Monster" } }
    assert_response :success
    @monster.reload
    assert_equal "Updated Monster", @monster.name
  end

  test "should not update monster with invalid params" do
    patch api_v1_monster_url(@monster), params: { monster: { name: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy monster" do
    assert_difference("Monster.count", -1) do
      delete api_v1_monster_url(@monster)
    end

    assert_response :no_content
  end

  test "should get monsters for a game" do
    get monsters_api_v1_monsters_url(id: @game.id)
    assert_response :success
    monsters = JSON.parse(response.body)
    assert_equal @game.monsters.count, monsters.length
  end

  test "should add monster to a game" do
    assert_difference("@game.monsters.count") do
      post add_monster_api_v1_monsters_url(id: @game.id), params: { monster: @monster_params }
    end

    assert_response :created
    new_monster = JSON.parse(response.body)
    assert_equal @monster_params[:name], new_monster["name"]
    assert_equal @game.id, new_monster["game_id"]
  end

  test "should remove monster from a game" do
    assert_difference("@game.monsters.count", -1) do
      delete remove_monster_api_v1_monsters_url(id: @game.id, monster_id: @monster.id)
    end

    assert_response :no_content
  end
end
