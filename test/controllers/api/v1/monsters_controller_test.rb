require "test_helper"

class Api::V1::MonstersControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  setup do
    setup_test_data
    @auth_token = login_user(@user)
  end

  test "should get index of all monsters" do
    get api_v1_monsters_url, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    monsters = JSON.parse(response.body)
    assert_equal Monster.count, monsters.length
  end

  test "Should get index of monsters for a specific game" do
    get api_v1_monsters_url, params: { game_id: @game.id }, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    monsters = JSON.parse(response.body)
    monsters.each do |monster|
      assert_equal @game.id, monster["game_id"]
    end
  end

  test "should show monster" do
    get api_v1_monster_url(@monster), headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    monster_response = JSON.parse(response.body)
    assert_equal @monster.name, monster_response["name"]
  end

  test "should create monster" do
    assert_difference("Monster.count") do
      post api_v1_monsters_url, params: { monster: @monster_params }, headers: { Authorization: "Bearer #{@auth_token}" }
    end

    assert_response :created
    new_monster = JSON.parse(response.body)
    assert_equal @monster_params[:name], new_monster["name"]
    assert_equal @monster_params[:size].to_s, new_monster["size"]
    assert_equal @monster_params[:alignment].to_s, new_monster["alignment"]
  end

  test "should not create monster with invalid params" do
    assert_no_difference("Monster.count") do
      post api_v1_monsters_url, params: { monster: @monster_params.merge(name: "") }, headers: { Authorization: "Bearer #{@auth_token}" }
    end

    assert_response :unprocessable_entity
  end

  test "should update monster" do
    patch api_v1_monster_url(@monster), params: { monster: { name: "Updated Monster" } }, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    @monster.reload
    assert_equal "Updated Monster", @monster.name
  end

  test "should not update monster with invalid params" do
    patch api_v1_monster_url(@monster), params: { monster: { name: "" } }, headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :unprocessable_entity
  end

  test "should destroy monster" do
    assert_difference("Monster.count", -1) do
      delete api_v1_monster_url(@monster), headers: { Authorization: "Bearer #{@auth_token}" }
    end

    assert_response :no_content
  end

  test "should get monsters for a game" do
    get monsters_api_v1_monsters_url(id: @game.id), headers: { Authorization: "Bearer #{@auth_token}" }
    assert_response :success
    monsters = JSON.parse(response.body)
    assert_equal @game.monsters.count, monsters.length
  end

  test "should add monster to a game" do
    assert_difference("@game.monsters.count") do
      post add_monster_api_v1_monsters_url(id: @game.id), params: { monster: @monster_params }, headers: { Authorization: "Bearer #{@auth_token}" }
    end

    assert_response :created
    new_monster = JSON.parse(response.body)
    assert_equal @monster_params[:name], new_monster["name"]
    assert_equal @game.id, new_monster["game_id"]
  end

  test "should remove monster from a game" do
    assert_difference("@game.monsters.count", -1) do
      delete remove_monster_api_v1_monsters_url(id: @game.id, monster_id: @monster.id), headers: { Authorization: "Bearer #{@auth_token}" }
    end

    assert_response :no_content
  end

  test "should toggle monster display to true" do
    @monster.update(displayed: false)
    patch toggle_display_api_v1_monster_url(@monster),
          params: { displayed: true },
          headers: { Authorization: "Bearer #{@auth_token}" }

    assert_response :success
    @monster.reload
    assert @monster.displayed
  end

  test "should toggle monster display to false" do
    @monster.update(displayed: true)
    patch toggle_display_api_v1_monster_url(@monster),
          params: { displayed: false },
          headers: { Authorization: "Bearer #{@auth_token}" }

    assert_response :success
    @monster.reload
    assert_not @monster.displayed
  end

  test "should return unprocessable entity for invalid monster display toggle" do
    patch toggle_display_api_v1_monster_url(@monster),
          params: { displayed: nil },
          headers: { Authorization: "Bearer #{@auth_token}" }

    assert_response :unprocessable_entity
  end
end
