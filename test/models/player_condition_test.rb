require "test_helper"

class PlayerConditionTest < ActiveSupport::TestCase
  test "valid player condition" do
    player_condition = player_conditions(:one)
    assert player_condition.valid?, "Player condition should be valid. Errors: #{player_condition.errors.full_messages}"
  end

  test "invalid without condition length" do
    player_condition = player_conditions(:one)
    player_condition.condition_length = nil
    assert_not player_condition.valid?
    assert_includes player_condition.errors[:condition_length], "can't be blank"
  end

  test "invalid with negative condition length" do
    player_condition = player_conditions(:one)
    player_condition.condition_length = -1
    assert_not player_condition.valid?
    assert_includes player_condition.errors[:condition_length], "must be greater than or equal to 0"
  end

  test "invalid without player" do
    player_condition = player_conditions(:one)
    player_condition.player = nil
    assert_not player_condition.valid?
    assert_includes player_condition.errors[:player], "must exist"
  end

  test "invalid without condition" do
    player_condition = player_conditions(:one)
    player_condition.condition = nil
    assert_not player_condition.valid?
    assert_includes player_condition.errors[:condition], "must exist"
  end

  test "invalid with duplicate player-condition combination" do
    existing_player_condition = player_conditions(:one)
    new_player_condition = PlayerCondition.new(
      condition_length: 1,
      player: existing_player_condition.player,
      condition: existing_player_condition.condition
    )
    assert_not new_player_condition.valid?
    assert_includes new_player_condition.errors[:base], "This player already has this condition"
  end
end
