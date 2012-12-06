require 'test_helper'

class SessionTest < ActiveSupport::TestCase
  test "scopes by scheduled" do
    assert_equal(3, Session.scheduled.count)
  end
  test "scopes by on_demand" do
    assert_equal(1, Session.on_demand.count)
  end
  test "scopes by active" do
    assert_equal(2, Session.active.count)
  end
  test "sorts active by start_datetime" do
    assert_equal(sessions(:on_demand), Session.active.first)
    assert_equal(sessions(:scheduled), Session.active.last)
  end
end
