require "test_helper"

class Api::V1::PlayerConditionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_condition = player_conditions(:one)
    @player = players(:jane)
    @condition = Condition.create!(name: "Temporary Test Condition #{Time.now.to_i}")
    @player_condition_params = {
      condition_length: 2,
      player_id: @player.id,
      condition_id: @condition.id
    }
  end

  test "should get index" do
    get api_v1_player_conditions_url
    assert_response :success
    player_conditions = JSON.parse(response.body)
    assert_equal PlayerCondition.count, player_conditions.length
  end

  test "should show player_condition" do
    get api_v1_player_condition_url(@player_condition)
    assert_response :success
    player_condition_response = JSON.parse(response.body)
    assert_equal @player_condition.condition_length, player_condition_response["condition_length"]
  end

  test "should create player_condition" do
    assert_difference("PlayerCondition.count") do
      post api_v1_player_conditions_url, params: { player_condition: @player_condition_params }
    end

    assert_response :created
    new_player_condition = JSON.parse(response.body)
    assert_equal @player_condition_params[:condition_length], new_player_condition["condition_length"]
  end

  test "should not create duplicate player_condition" do
    assert_no_difference("PlayerCondition.count") do
      post api_v1_player_conditions_url, params: { player_condition: {
        condition_length: 1,
        player_id: @player_condition.player_id,
        condition_id: @player_condition.condition_id
      } }
    end

    assert_response :unprocessable_entity
  end

  test "should update player_condition" do
    patch api_v1_player_condition_url(@player_condition), params: { player_condition: { condition_length: 3 } }
    assert_response :success
    @player_condition.reload
    assert_equal 3, @player_condition.condition_length
  end

  test "should not update player_condition with invalid params" do
    patch api_v1_player_condition_url(@player_condition), params: { player_condition: { condition_length: -1 } }
    assert_response :unprocessable_entity
  end

  test "should destroy player_condition" do
    assert_difference("PlayerCondition.count", -1) do
      delete api_v1_player_condition_url(@player_condition)
    end

    assert_response :no_content
  end
end
