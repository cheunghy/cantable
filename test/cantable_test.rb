require 'test_helper'

class CanTableTest < ActiveSupport::TestCase

  test "CanTable module exists" do
    assert_kind_of Module, CanTable
  end

  test "can_table method is defined" do
    assert ApplicationController.method_defined?(:can_table),
           "can_table should be defined"
  end

  test "cancancan can be retrieved" do
    assert Ability.new(""), "Ability should be created"
  end

end
