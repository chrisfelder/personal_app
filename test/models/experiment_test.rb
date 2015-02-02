require 'test_helper'

class ExperimentTest < ActiveSupport::TestCase
  include ExperimentsHelper
  
  test "run quick_sort" do
    #assert_equal [1,2], quick_sort([2,1], 2), "Should return a sorted array"
  end

  test "run partition" do
    assert_equal [1, 2, 3, 5, 8, 4, 7, 6], partition([3, 8, 2, 5, 1, 4, 7, 6], 0, 7)
  end
end
