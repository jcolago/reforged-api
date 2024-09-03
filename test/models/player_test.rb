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

  test "calling calculate_ability_bonuses for intelligence 20" do
    player = players(:joe)
    player.intelligence = 20
    player.save

    assert_equal 5, player.int_bonus
  end

  test "calling calculate_ability_bonuses for intelligence 5" do
    player = players(:joe)
    player.intelligence = 5
    player.save

    assert_equal -3, player.int_bonus
  end

  test "calling calculate_ability_bonuses for wisdom 20" do
    player = players(:joe)
    player.wisdom = 20
    player.save

    assert_equal 5, player.wis_bonus
  end

  test "calling calculate_ability_bonuses for wisdom 6" do
    player = players(:joe)
    player.wisdom = 11
    player.save

    assert_equal 0, player.wis_bonus
  end

  test "calling calculate_ability_bonuses for charisma 20" do
    player = players(:joe)
    player.charisma = 20
    player.save

    assert_equal 5, player.cha_bonus
  end

  test "calling calculate_ability_bonuses for charisma 8" do
    player = players(:joe)
    player.charisma = 8
    player.save

    assert_equal -1, player.cha_bonus
  end

  test "current_hp cannot exceed total_hp" do
    player = players(:joe)
    player.total_hp = 20
    player.current_hp = 30

    assert_not player.valid?
    assert_includes player.errors[:current_hp], "can't exceed total HP"
  end

  test "current_hp can equal total_hp" do
    player = players(:joe)
    player.total_hp = 20
    player.current_hp = 20

    assert player.valid?
  end

  test "current_hp can be less than total_hp" do
    player = players(:joe)
    player.total_hp = 20
    player.current_hp = 15

    assert player.valid?
  end
end
