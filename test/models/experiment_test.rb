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


  
  #test "create_graph should create a graph" do
  #  test_hash = { }
  #  assert_equal test_hash, create_graph(temp_string)
  #end
  
  #test "dfs_loop should return a visited graph" do
  # assert_equal [], dfs_loop(create_graph(temp_string))
  #end
  
  #test "brent_cycle should return a cycle I" do
  #  assert_equal "6 3 1", detect_loop("2 0 6 3 1 6 3 1 6 3 1")
  #end
#  
#  test "brent_cycle should return a cycle II" do
#    assert_equal "49", detect_loop("3 4 8 0 11 9 7 2 5 6 10 1 49 49 49 49")
#  end
#  test "brent_cycle should return a cycle III" do
#    assert_equal "1 2 3", detect_loop("1 2 3 1 2 3 1 2 3")
#  end
  
  #test "should return max sum" do
  #  #assert_equal 27, pass_triangle(passed_array).to_s
  #  assert_equal 27, pass_triangle(passed_array).to_s
  #end
  
  #  
  #temp_array.each do |x|
  #    passed_array << x[0].split(" ")
  #end
  #if temp_array[0][0][0] == "1"
  #  passed_array.unshift(["0 0,0"])
  #end
  #temp_array = []
  #passed_array.each.with_index do |x, index|
  #  x.each_with_index do |y, inner_index|
  #    if inner_index == 0
  #      passed_array[index][inner_index] = y.to_i
  #    else
  #      passed_array[index][inner_index] = y.split(",")
  #      passed_array[index][inner_index].each_with_index do |z, array_index|
  #        passed_array[index][inner_index][array_index] = z.to_i
  #      end
  #    end
  #    
  #  end
  #  passed_array[index].shift
  #end

  #test "should return shortest path through maze" do
  #  assert_equal 43, maze_path(temp_array)
  #end
  
  #test "should return the shortest path through graph" do
  #  assert_equal 9, shortestpath(passed_array, 1, 197)
  #
  #end
  
  temp_array = []
  passed_array = []
  filex = File.open(Rails.root.to_s + "/lib/assets/codeeval/discount2.txt", "r")
  filex.each_line do |line|
    temp_array = line.strip.downcase.split(";")
  end
  
  #temp_array.each.with_index do |x, index|
  #  temp_array[index] = x.delete(" ").split(",")
  #  
  #  if index == 0
  #    temp_array[0].each.with_index do |y, inner_index|
  #      length = y.length
  #      vowels = y.count('aeiouy')
  #    temp_array[0][inner_index] = [length, vowels]
  #    end
  #  
  #  else 
  #    temp_array[1].each.with_index do |y, inner_index|
  #      y.gsub!(/[^a-z]/, '')
  #      temp_array[1][inner_index] = [y.length, y.length % 2 == 0]
  #    end
  #  end
  #end
  

  
  

  
  #test "should return the total score for discount" do
  #  assert_equal [[[11, 4], [9, 3], [9, 4]], [[8, true], [19, false], [12, true]]],
  #    discountx(temp_array)
  #end
  
#  test "integers with common factors should return true" do
#    assert compare_factors?(10, 8)
#  end
#  
#  test "integers with no common factors should return false" do
#    assert_not compare_factors?(19, 91)
#  end
#  
#  test "modulo should return the modulo" do
#    assert_equal 2, modulo("20,6")
#  end
#  
#  test "modulo should return the moduloII" do
#    assert_equal 2, modulo("2,3")
#  end
#  
#  test "sum_ints should return true O " do
#    assert_equal 30, sum_ints(59, 79)
#  end
#  
#  test "sum_ints should return true II" do
#    assert_equal 12, sum_ints(5, 7)
#  end
#  
  #test "grid_walk should return true" do
  #  assert_equal 4030, grid_walk()
  #end
  
  #test "string_list shoudl return array" do
  #  assert_equal ["aa,ab,ba,bb"], string_list("3,abc")
  #end
  
  temp_array = []
  passed_array = []
  int_array = []
  node_count = 0
  filex = File.open(Rails.root.to_s +
          "/lib/assets/algorithms2/assignment2/clustering1.txt", "r")

          
  filex.each_line do |line|
    if node_count == 0
      node_count = line.to_i
      next
    end
    
    temp_line = line.split(" ")
    temp_line.each.with_index do |x, index|
      temp_line[index] = x.to_i
    end
    passed_array << temp_line
  end
  filex.close

  #test "cluster_max returns 6 for 2 clusters" do
  #  assert_equal 6, cluster_max(clusters, 4, passed_array)
  #end



end
