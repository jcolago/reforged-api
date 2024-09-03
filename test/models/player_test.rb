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

  test "calling calculate_ability_bonuses for dexterity 20" do
    player = players(:joe)
    player.dexterity = 20
    player.save

    assert_equal 5, player.dex_bonus
  end

  test "calling calculate_ability_bonuses for dexterity 14" do
    player = players(:joe)
    player.dexterity = 6
    player.save

    assert_equal -2, player.dex_bonus
  end

  test "calling calculate_ability_bonuses for constitution 20" do
    player = players(:joe)
    player.constitution = 20
    player.save

    assert_equal 5, player.con_bonus
  end

  test "calling calculate_ability_bonuses for constitution 8" do
    player = players(:joe)
    player.constitution = 8
    player.save

    assert_equal -1, player.con_bonus
  end
end
