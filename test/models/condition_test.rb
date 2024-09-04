require "test_helper"

class ConditionTest < ActiveSupport::TestCase
  setup do
    @conditions = conditions(:poisoned)
  end
  test "valid condititon" do
    assert @conditions.valid?
  end

  test "invalid without name" do
    @conditions.name = nil
    assert_not @conditions.valid?
    assert_includes @conditions.errors[:name], "can't be blank"
  end
end
