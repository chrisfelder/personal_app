require 'test_helper'

class ExperimentTest < ActiveSupport::TestCase
  include ExperimentsHelper
  array = []
  verteces = 0
  #file = File.open(Rails.root.to_s + "/lib/assets/algorithms/quicksort.txt", "r")
  #file.each_line do |line|
  #  array << line.to_i
  #end
  #file.close
  
  #test "run quick_sort" do
  #  assert_equal [1, 2, 3, 4], quick_sort([2,1, 4, 3], 4), "Should return a sorted array"
  #end
  
  #test "run quick_sort_full" do
  #  assert_equal [1, 2, 3, 4, 5, 6, 7, 8], quick_sort([3, 8, 2, 5, 1, 4, 7, 6], 8)
  #end

  #test "run partition" do
  #  assert_equal [1, 2, 3, 5, 8, 4, 7, 6], partition([3, 8, 2, 5, 1, 4, 7, 6], 0, 7)
  #end
  
  #test "run quicksort on small sample file" do
  #  assert_equal [609, 2148, 3153, 6324, 7628, 7742, 9058], quick_sort(array, 7)
  #end
  
  filex = File.open(Rails.root.to_s + "/lib/assets/algorithms/mincut_full.txt", "r")
  filex.each_line do |line|
    temp_array = line.split(' ')
    v1 = temp_array[0]
    temp_array.shift
    verteces += 1
    temp_array.each do |x|
      if x > v1
        array << [v1, x]
      end
    end
    
  end
  filex.close
  
  test "Run first test" do
    temp_min = 0
    final_min = 999
    (0..4).each do |d|
      temp_array = Marshal.load( Marshal.dump(array))
      #puts array.to_s
      #puts "Outside method verteces: " + verteces.to_s
      temp_min = mincut(temp_array, verteces)
      if temp_min < final_min
        final_min = temp_min
      end
    end
    assert_equal 17, final_min
  end
  
end
