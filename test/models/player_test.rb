require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  setup do
    @player = players(:joe)
  end

  test "valid player" do
    assert @player.valid?
  end

  test "invalid without name" do
    @player.name = nil
    assert_not @player.valid?
    assert_includes @player.errors[:name], "can't be blank"
  end

  test "invalid without character" do
    @player.character = nil
    assert_not @player.valid?
    assert_includes @player.errors[:character], "can't be blank"
  end

  test "invalid with non-integer attributes" do
    integer_attributes = [ :level, :current_hp, :total_hp, :armor_class, :speed, :initiative_bonus,
                          :strength, :str_save, :dexterity, :dex_save, :constitution, :con_save,
                          :intelligence, :int_save, :wisdom, :wis_save, :charisma, :cha_save ]

    integer_attributes.each do |attr|
      @player[attr] = "not an integer"
      assert_not @player.valid?
      assert_includes @player.errors[attr], "is not a number"
      @player.reload  # Reset for next iteration
    end
  end

  test "invalid without game" do
    @player.game = nil
    assert_not @player.valid?
    assert_includes @player.errors[:game], "must exist"
  end

  test "displayed must be boolean" do
    @player.displayed = nil
    assert_not @player.valid?
    assert_includes @player.errors[:displayed], "is not included in the list"

    @player.displayed = true
    assert @player.valid?

    @player.displayed = false
    assert @player.valid?
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
