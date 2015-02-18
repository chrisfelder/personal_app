require 'test_helper'

class ExperimentTest < ActiveSupport::TestCase
  include ExperimentsHelper
  #array = []
  #verteces = 0
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
  
  #filex = File.open(Rails.root.to_s + "/lib/assets/algorithms/mincut_full.txt", "r")
  #filex.each_line do |line|
  #  temp_array = line.split(' ')
  #  v1 = temp_array[0]
  #  temp_array.shift
  #  verteces += 1
  #  temp_array.each do |x|
  #    if x > v1
  #      array << [v1, x]
  #    end
  #  end
    
  #end
  #filex.close
#  
#  test "Run first test" do
#    temp_min = 0
#    final_min = 999
#    (0..4).each do |d|
#      temp_array = Marshal.load( Marshal.dump(array))
#      #puts array.to_s
#      #puts "Outside method verteces: " + verteces.to_s
#      temp_min = mincut(temp_array, verteces)
#      if temp_min < final_min
#        final_min = temp_min
#      end
#    end
#    assert_equal 17, final_min
#  end

  #p1 = [10, 0]
  #q1 = [0, 10]
  #p2 = [0, 0]
  #q2 = [10, 10]
  
  #test "orientation returns counter-clockwise" do
  #  assert_equal 2, orientation(p1, q1, p2)
  #end
  
  #test "orientation returns clockwise" do
  #  assert_equal 1, orientation(p2, q1, p1)
  #end
  
  #test "orientation returns colinear" do
  #  assert_equal 0, orientation(p2, q1, p2)
  #end
  
  #test "two lines should not intersect" do
  #  assert_not intersect?(p1, p2, q1, q2)
  #end
  
  #test "two lines should intersect" do
  #  assert intersect?(p1, q1, p2, q2)
  #end
  
  #test "parsebridges should parse first line" do
  #  assert_equal [[1, [37.788353, -122.387695], [37.829853, -122.294312], []]], parsebridges("1: ([37.788353, -122.387695], [37.829853, -122.294312])")
  #end
  
  #test "parsebridge should parse all lines" do
  #  assert_equal [[1, [37.788353, -122.387695], [37.829853, -122.294312], []],[2, [37.429615, -122.087631], [37.487391, -122.018967], []]],
  #  parsebridges(temp_string)
  #end
  #test "positive slope? returns true" do
  #  assert slope?([0,0], [1, 1])
  #end
  
  #test "negative slope? returns false" do
  #  assert_not slope?([0,0], [-1, 1])
  #end
  
#  test "baybridge should return lowest intersections" do
#    assert_equal [[2, [37.429615, -122.087631], [37.487391, -122.018967], []], [1, [37.788353, -122.387695], [37.829853, -122.294312], []]],
#    baybridgex(parsebridges(temp_string))
#  end

  temp_string = ""
  filex = File.open(Rails.root.to_s + "/lib/assets/algorithms/scc12.txt", "r")
  filex.each_line do |line|
    temp_string << line
  end
  filex.close
  
  #test "create_graph should create a graph" do
  #  test_hash = { }
  #  assert_equal test_hash, create_graph(temp_string)
  #end
  
  test "dfs_loop should return a visited graph" do
    assert_equal [], dfs_loop(create_graph(temp_string))
  end
end
