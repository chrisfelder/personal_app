require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  include TracksHelper

  test "should return stdev of 0 for array of equal numbers" do
    assert_equal 0.0, stdev([1.0, 1.0, 1.0])
  end
  
  test "should return stdev of 1.15 for array" do
    assert_equal 1.15, stdev([5.0, 5.0, 7.0])
  end
end
