require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  test "the name should be present" do
    player = players(:joe)
    assert_equal player.name, "Joe"
  end

  test "calling calculate_ability_bonuses for strenth 20" do
    player = players(:joe)
    player.strength = 20
    player.save

    assert_equal 5, player.str_bonus
  end

  test "calling calculate_ability_bonuses for strenth 0" do
    player = players(:joe)
    player.strength = 0
    player.save

    assert_equal -5, player.str_bonus
  end
end
