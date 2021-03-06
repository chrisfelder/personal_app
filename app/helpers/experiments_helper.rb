module ExperimentsHelper
  
  def sort_and_countx(array, length)
    temp = sort_and_count(array, length)
    return temp[1]
  end
  
  def sort_and_count(array, length)
    b = []
    c = []
    d = []

    sub_length = (length / 2)
    sub_b = array[0..sub_length - 1]
    sub_c = array[sub_length..length - 1]
    
    if length == 1
      return [array, 0]
    else
      b = sort_and_count(sub_b , sub_b.length)
      c = sort_and_count(sub_c, sub_c.length)
      d = merge_and_count(b[0], c[0], b[0].length + c[0].length)
    end
    d[1] = d[1] + b[1] + c[1]
    return d
  end

  def merge_and_count(array_b, array_c, length)
    output = []
    inversion_count = 0
    j = 0
    k = 0
    for i in 0...length
      if array_b[j].nil?
        output[i] = array_c[k]
        k += 1
      elsif array_c[k].nil?
        output[i] = array_b[j]
        j += 1
      elsif array_b[j] < array_c[k]
        output[i] = array_b[j]
        j += 1
      else
        output[i] = array_c[k]
        inversion_count += array_b.length - j
        k += 1
      end
      
    end
    return [output, inversion_count]
  end
  
  def sortx(array)
    b = []
    c = []
    d = []

    sub_length = (array.length / 2)
    sub_b = array[0..sub_length - 1]
    sub_c = array[sub_length..length - 1]
    
    if length == 1
      return [array, 0]
    else
      b = sortx(sub_b)
      c = sortx(sub_c)
      d = mergex(b, c)
    end
    return d
  end

  def mergex(array_b, array_c)
    output = []
    j = 0
    k = 0
    length = array_b.length + array_c.length
    for i in 0...length
      if array_b[j].nil?
        output[i] = array_c[k]
        k += 1
      elsif array_c[k].nil?
        output[i] = array_b[j]
        j += 1
      elsif array_b[j] < array_c[k]
        output[i] = array_b[j]
        j += 1
      else
        output[i] = array_c[k]
        k += 1
      end
      
    end
    return [output]
  end
  
  
  def quick_sort(array, length)

    if length == 1 || length == 0
      return array
    else
      pivot = choose_pivot(array, length)
      #array = partition(array, pivot, length - 1)
      
      #make sure to switch the element at the pivot index with the first element
      
      i = pivot + 1
      j = pivot + 1
      for x in j..length - 1
        if array[j] < array[pivot]
          array[j], array[i] = array[i], array[j]
          i += 1
        end
        j += 1
      end
      
      array[pivot], array[i - 1] = array[i - 1], array[pivot]

      #recursively sort array < p
      array[0..(i - 2)] = quick_sort(array[0..(i - 2)], i - 1)
      
      #recursively sort array > p
      array[i..(length - 1)] = quick_sort(array[i..(length - 1)], (length - i))
      
      return array
    end
  end
  
  def choose_pivot(array, length)
    return 0
  end
  
  def choose_pivot_last(array, length)
    return (array.length - 1)
  end
  
  def choose_pivot_median(array, length)
    if length == 2 || array.length == 2
      return 0
    end
    
    half = ((array.length + 1) / 2) - 1
    first = array.first
    middle = array[half]
    #array.length % 2 == 0 ? middle = array[half - 1] : middle = array[half] 
    last = array.last
    
    if first >= last && first <= middle || first <= last && first >= middle
      return 0
    elsif last > first && last < middle || last < first && last > middle
      return length - 1
    else
      return half
    end
    
    
    
  end
  
  # 3 8 2 5 1 4 7 6 or # 2 1 4 3
  def partition(array, left, right)

    pivot = array[left]
    i = left + 1
    j = left + 1
    for x in j..right
      if array[j] < pivot
        array[j], array[i] = array[i], array[j]
        i += 1
      end
      j += 1
    end
    array[left], array[i - 1] = array[i - 1], array[left]
    return array
  end
  
  
  
  def quick_sort_count(array)
    #puts "This is the array entering quicksortx: " + array.to_s
    temp = quick_sortx(array, array.length)
    puts "And this is the sum: " + temp[1].to_s
    puts "This is the final array: " + temp[0].to_s
    return temp[1]
  end
  
  def quick_sortx(array, length)
     
    if length == 1 || length == 0
      return [array, 0]
    else
      pivot = choose_pivot_last(array, length)
      array[pivot], array[0] = array[0], array[pivot]
      pivot = 0
      
      sub_array = []
      i = pivot + 1
      j = pivot + 1
      for x in j..length - 1
        if array[j] < array[pivot]
          array[j], array[i] = array[i], array[j]
          i += 1
        end
        j += 1
      end
      
      array[pivot], array[i - 1] = array[i - 1], array[pivot]
      #puts "This is the array after partitioning: " + array.to_s


      i > 1 ? sub_left = array[0..(i - 2)]: sub_left = []
      #puts "This is the sub_left going into the left recursive call: " + sub_left.to_s
      sub_right = array[i..(length - 1)]
      #puts "This is the sub_right going into the right recursive call: " + sub_right.to_s
      
      #recursively sort array < p
      left = quick_sortx(sub_left, i - 1)
      #puts "This is the left array after quicksortx: " + left[0].to_s
      #i > 1 ? left[1] += (i - 1) : left[1] += 1
      
      #recursively sort array > p
      right = quick_sortx(sub_right, (length - i))
      #right[1] += (right[0].length - 1)
      
      
      left[0].each do |z|
        sub_array << z
      end
      
      #puts "After appending left sub_array: " + sub_array.to_s
      sub_array << array[i - 1]
      
      right[0].each do |y|
        sub_array << y
      end
      
      #puts "After appending right sub_array: " + sub_array.to_s
      sum = (sub_array.length - 1) + left[1] + right[1]
      return [sub_array, sum]
    end
  end
  
  def mincut(array, verteces)
    delete_array = []
    adjust_delete = 0
    
    while verteces > 2
    temp = Random.new.rand(1..(array.length))
    temp_vertex = array[temp - 1]
    array.delete_at(temp - 1)
    array.each.with_index do |value, index|
      if value[0] == temp_vertex[1]
        array[index][0] = temp_vertex[0]
        
     elsif value[1] == temp_vertex[1]
       array[index][1] = temp_vertex[0]
      end
      
      if value[0] > value[1]
        value[0], value[1] = value[1], value[0]
        
      elsif value[0] == value[1]
        delete_array << index
      end
    end

    delete_array.each do |x|
      array.delete_at(x - adjust_delete)
      adjust_delete += 1
    end
    adjust_delete = 0
    delete_array = []
    
    verteces -= 1
    end
    return array.length
  end
  
  def on_segment?(point_p, point_q, point_r)
    if (q[0] <= [point_p[0], point_r[0]].max &&
        point_q[0] >= [point_p[0], point_r[0]].min &&
        point_q[1] <= [point_p[1], point_r[1]].max &&
        point_q[1] >= [point_q[1], point_r[1]].min)
      true
    else
      false
    end
  end
  
  #returns true if positive, false if negative
  #def slope?(p1, p2)
  #  slope = (p2[1] - p1[1])/(p2[0] - p1[0])
  #  
  #  if slope < 0
  #    false
  #  else
  #    true
  #  end
  #end
  
  def orientation(point_p, point_q, point_r)

    temp = (point_q[1] - point_p[1]) * (point_r[0] - point_q[0]) -
           (point_q[0] - point_p[0]) * (point_r[1] - point_q[1])
           
    if (temp == 0)
       0  #the orientation is colinear
    elsif temp > 0
       1  #the orientation is clockwise
    else
       2  #the orientation is counter-clockwise
    end
  end
  
  def intersect?(p1, q1, p2, q2)

    #finds the four orientations
    orientation1 = orientation(p1, q1, p2)
    orientation2 = orientation(p1, q1, q2)
    orientation3 = orientation(p2, q2, p1)
    orientation4 = orientation(p2, q2, q1)
    
    #tests for intersections in the general case
    #may need to test for special cases in future iterations
    if (orientation1 != orientation2 && orientation3 != orientation4)
      return true
    end
    
    if orientation1 == 0 && on_segment?(p1, p2, q1)
      return true
    end
    
    if orientation2 == 0 && on_segment?(p1, q2, q1)
      return true
    end
    
    if orientation3 == 0 && on_segment?(p2, p1, q2)
      return true
    end
      
    if orientation4 == 0 && on_segment?(p2, q1, q2)
      return true
    end
    
    return false
  end
  

  
  def parsebridges(string)
    temp_array = []
    intermediate_array = []
    tempy_array = string.split(/\(([^\)]+)\)/)
    
    
    tempy_array.each.with_index do |str, index|
      if index % 2 != 0
        intermediate_array << str.scan(/-?\d+\.\d+/)
      end
    end
    
    intermediate_array.each.with_index do |array, index|
      temp_array[index] = index + 1, [array[0].to_f, array[1].to_f],
                           [array[2].to_f, array[3].to_f], []
    end
    
    return temp_array
  end
  
  def baybridge(array)
    delete_array = []
    temp_array = array.sort_by { |point| point[1][0] }
    temp_array.each.with_index do |value, index|
      adj = 1
      while temp_array[index + adj] && 
              intersect?(temp_array[index][1],
                         temp_array[index][2],
                         temp_array[index + adj][1],
                         temp_array[index + adj][2]) do
          #puts "Bridge " + value[0].to_s + "intersected with " + temp_array[index + adj][0].to_s

        if value[3].include?( temp_array[index + adj][0]) == false
          value[3] << temp_array[index + adj][0]
        end
        
        if temp_array[index + adj][3].include?(value[0]) == false
          temp_array[index + adj][3] << value[0]
        end
          
          adj += 1
      end
      
      adj = 1  
      while temp_array[index - adj] && 
          intersect?(temp_array[index][1],
                     temp_array[index][2],
                     temp_array[index - adj][1],
                     temp_array[index - adj][2]) do
        if value[3].include?( temp_array[index - adj][0]) == false
          value[3] << temp_array[index - adj][0]
        end
        
        if temp_array[index - adj][3].include?( value[0]) == false
          temp_array[index - adj][3] << value[0]
        end
        adj += 1
      end
      
    end
    
    temp_array = temp_array.sort_by { |point| point[3].length }.reverse!
    puts temp_array.to_s
    
    temp_array.each.with_index do |value, index|
      if value[3].length > 0
        value[3].each do |bridge|
          temp_index = temp_array.index { |a| a[0] == bridge}
          #temp_bridge[0][3].delete_if { |b| b == value[0]}
          temp_array[temp_index][3].delete_if { |b| b == value[0]}
        end
        delete_array << index
      end
    end
    
    delete_array.each do |to_delete|
      temp_array[to_delete] = nil
    end
    
    temp_array.compact!
    
    temp_array = temp_array.sort_by { |bridge_num| bridge_num[0] }
    
    temp_array.each do |bridge|
      puts bridge[0]
      #puts bridge.to_s
    end
     #temp_array
  end
  
  def baybridgex(array)
    delete_array = []
    temp_array = array.sort_by { |point| point[1][0] }
    temp_array.each.with_index do |value, index|
      adj = 1
      until temp_array[index + adj].nil?  do
        if intersect?(temp_array[index][1],
                         temp_array[index][2],
                         temp_array[index + adj][1],
                         temp_array[index + adj][2])
          
          
          if value[3].include?( temp_array[index + adj][0]) == false
          #  puts "bridge " + temp_array[index + adj][0].to_s + " is about to enter" +
          #       "bridge " + value[0].to_s + " " + value [3].to_s 
            value[3] << temp_array[index + adj][0]
          end
        
          if temp_array[index + adj][3].include?(value[0]) == false
          #  puts "bridge " + value [0].to_s + " is about to enter" +
          #       "bridge "  + temp_array[index + adj][0].to_s + " " +
                 temp_array[index + adj][3].to_s
            temp_array[index + adj][3] << value[0]
          end
        end
        adj += 1
      end
    end
    
    temp_array = temp_array.sort_by { |point| point[3].length }.reverse!
    #puts temp_array.to_s
    
    temp_array.each.with_index do |value, index|
      if value[3].length > 0
        value[3].each do |bridge|
          temp_index = temp_array.index { |a| a[0] == bridge}
          #temp_bridge[0][3].delete_if { |b| b == value[0]}
          temp_array[temp_index][3].delete_if { |b| b == value[0]}
        end
        delete_array << index
      end
    end
    
    delete_array.each do |to_delete|
      temp_array[to_delete] = nil
    end
    
    temp_array.compact!
    
    temp_array = temp_array.sort_by { |bridge_num| bridge_num[0] }
    
    temp_array.each do |bridge|
      puts bridge[0]
      #puts bridge.to_s
    end
     #temp_array
  end
  
  #
  #  [ index, [array out], [array in], visited?, time]
  #     0         1           2           3       4 
  def create_graph(string)
    final_array = []
    temp_array = []
    graph_array = string.split("\n")
    graph_array.each do  |x|
      temp_array << x.split(" ").map(&:to_i)
    end
    
    temp_array.each do |x|
      #creates a new vertex if it does not exist, populates with outgoing vertex
      if final_array[x[0] - 1].nil?
        final_array[x[0] - 1] = [x[0] - 1, [x[1] - 1], [], false, 0]
      else
        final_array[x[0] - 1][1] << x[1] - 1
      end
      #if vertex does not exist, creates new vertex with incoming vertex
      if final_array[x[1] - 1].nil?
        final_array[x[1] - 1] = [x[1] - 1, [], [x[0] - 1], false, 0]
      else
        final_array[x[1] - 1][2] << x[0] - 1
      end
    end
    
    final_array
  end
  
  #  [ index, [array out], [array in], visited?, time, leaderhead]
  #     0         1           2           3       4       5
  def dfs_loop(graph)
    returned_array = []
    time = 0
    to_visit = []
    graph.reverse.each.with_index do |val, index|
      if val.nil?
        next
      end
      visited = []
      if val[3] == false
        val[2].each do |next_index|
          if graph[next_index][3] == false
            to_visit << next_index
          end
        end
        next_vert = to_visit.pop
        val[3] = true
        visited << val[0]
        if next_vert.nil? == false
          while graph[next_vert][3] == false || to_visit != [] do
            if graph[next_vert][3] == true
              next_vert = to_visit.pop
              next
            end
            
            graph[next_vert][3] = true
            visited << graph[next_vert][0]
            
            graph[next_vert][2].each do |next_index|
              if graph[next_index][3] == false
                
                to_visit << next_index
              end
            end
            
            if to_visit != []
              next_vert = to_visit.pop
            else
              break
            end
            
          end #while loop
        end
        
        visited.reverse.each do |x|
          graph[x][4] = time
          returned_array << [time, graph[x][0]]
          time += 1
        end
        
      end
    end #outer for loop
    dfs_countx(graph, returned_array.reverse)
  end
  

  def dfs_countx(graph, array)
    to_visit = []
    count_array = []
    array.each.with_index do |val, index|
      if graph[val[1]].nil?
        next
      end
      
      if graph[val[1]][3] == true
        graph[val[1]][1].each do |next_index|
          if graph[next_index][3] == true
            to_visit << next_index
          end
        end
        next_vert = to_visit.pop
        graph[val[1]][3] = false
        temp_array = [val[0], 1]
        if next_vert.nil? == false
          while graph[next_vert][3] == true || to_visit != []
            if graph[next_vert][3] == false
              next_vert = to_visit.pop
              next
            end
            
            graph[next_vert][3] = false
            temp_array[1] += 1
          
            graph[next_vert][1].each do |next_index|
              if graph[next_index][3] == true
                to_visit << next_index
              end
            end
            
            if to_visit != []
              next_vert = to_visit.pop
            else
              break
            end
          end #inner while
          
        end
        count_array << temp_array[1]
      end #if statement
    end #outer loop
    count_array = count_array.sort! {|x, y| y <=> x}
    count_array[0..6]
  end
  
  def detect_loop(string)
    cycle_array = ""
    index_array = []
    next_index = 0
    temp_array = string.split(" ")
    temp_array.each.with_index do |x, index|
      if index_array[x.to_i].nil?
        index_array[x.to_i] = temp_array[index + 1].to_i
      else  #the index already exists so there must be a cycle
        cycle_array << x + " "
        head_index = x.to_i
        next_index = index_array[x.to_i]
        while head_index != next_index
         cycle_array << next_index.to_s + " "
          next_index = index_array[next_index]
          
        end
        break
      end
    end
    cycle_array.chomp(" ")
  end
  
  #Passed an array of triangles in ascending size:
  #     [1]
  #   [2][3]
  #returns an array of the highest sum of a traversal from top to bottom
  #by adding adjacent values. In this example 4 would be the highest sum.
  #Computes the highest value of the bottom row and procedes to add these
  #values to the next row.
  def pass_triangle(array)
    array = array.reverse!
    array.each.with_index do |var, index|
    temp_array = []
      var.each.with_index do |int, inner_index|
        if var[inner_index + 1].nil? == false && int >= var[inner_index + 1]
          temp_array << int
        elsif var[inner_index + 1].nil? == false && int < var[inner_index + 1]
          temp_array << var[inner_index + 1]
        else
          break
        end
      end
      if array[index + 1].nil? == false
        array[index + 1] = array[index + 1].zip( temp_array).map {|a| a.inject(:+)}
      else
        
      end
    end
    array.last.first
  end
  
  #accepts a 2D array with a maze, computes the shortest path recursively
  def maze_path(maze)
    maze
  end
  
  #Accepts a graph in array form, a source node, and an array of nodes
  #for the algorithm to compute the shortest path from the source
  #   grapp is an array ordered by node number starting with 0th or 1st node
  #
  #   [[[edge, length], [edge, length]], [[edge, length]]]
  # Node:     0                                 2
  def shortestpath(graph, source, verts)
    edge_array = []
    v_array = (0..graph.length - 1).to_a
    distance = 0
    returned_distance = 0
    #sets up x & accounts for 0 being an empty node
    if graph[0] = []
      x_array = [[0, 0], [source, 0]]
      v_array.delete(0)
      v_array.delete(source)
    else
      x_array = [[source, 0]]
      v_array.delete(source)
    end
    
    #searches each visited vertex's outgoing edges, finds the minimum
    #length to the next unvisited node, and saves the node with the shortest
    #length
    until v_array.length == 0
      temp_length = Float::INFINITY
      x_array.each.with_index do |vertex, x_index|
        distance = x_array[x_index][1]
        graph[vertex[0]].each.with_index do |edge, index|
          if v_array.include?(graph[vertex[0]][index][0])
            if graph[vertex[0]][index][1] + distance < temp_length
              temp_length = graph[vertex[0]][index][1] + distance #shortest distance
              edge_array = [vertex[0], graph[vertex[0]][index][0]] #shortest edge
            end
          end
        end
      end
      x_array << [edge_array[1], temp_length]

      if edge_array[1] == verts
        returned_distance = temp_length
      end
      v_array.delete(edge_array[1])
      
    end
    
    #returns the length for the specified source and ending nodes
    returned_distance
  end
  

  
  #compares two numbers<n = 1 - 30 based on their prime factors
  def generate_factors
    factors = []
    temp_array = []
    temp_comp = []
    (0..100).each do |x|
      temp_array << x
    end
    temp_array.each.with_index do |x, index|
      temp_comp[index] = []
      if x == 0 || x == 1
        temp_comp[index] = [x]
      else
        factors << x
        factors.each do |y|
          if x % y == 0
            temp_comp[index] << y
          end
        end
      end
    end
    temp_comp
  end
  #compares two integers, returns true if they share a factor other than 1
  def compare_factors?(var1, var2)
    factors = [[0], [1], [2], [3], [2, 4], [5], [2, 3, 6], [7], [2, 4, 8],
    [3, 9], [2, 5, 10], [11], [2, 3, 4, 6, 12], [13], [2, 7, 14], [3, 5, 15],
    [2, 4, 8, 16], [17], [2, 3, 6, 9, 18], [19], [2, 4, 5, 10, 20], [3, 7, 21],
    [2, 11, 22], [23], [2, 3, 4, 6, 8, 12, 24], [5, 25], [2, 13, 26], [3, 9, 27],
    [2, 4, 7, 14, 28], [29], [2, 3, 5, 6, 10, 15, 30], [31], [2, 4, 8, 16, 32],
    [3, 11, 33], [2, 17, 34], [5, 7, 35], [2, 3, 4, 6, 9, 12, 18, 36], [37],
    [2, 19, 38], [3, 13, 39], [2, 4, 5, 8, 10, 20, 40], [41],
    [2, 3, 6, 7, 14, 21, 42], [43], [2, 4, 11, 22, 44], [3, 5, 9, 15, 45],
    [2, 23, 46], [47], [2, 3, 4, 6, 8, 12, 16, 24, 48], [7, 49],
    [2, 5, 10, 25, 50], [3, 17, 51], [2, 4, 13, 26, 52], [53],
    [2, 3, 6, 9, 18, 27, 54], [5, 11, 55], [2, 4, 7, 8, 14, 28, 56], [3, 19, 57],
    [2, 29, 58], [59], [2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60], [61],
    [2, 31, 62], [3, 7, 9, 21, 63], [2, 4, 8, 16, 32, 64], [5, 13, 65],
    [2, 3, 6, 11, 22, 33, 66], [67], [2, 4, 17, 34, 68], [3, 23, 69],
    [2, 5, 7, 10, 14, 35, 70], [71], [2, 3, 4, 6, 8, 9, 12, 18, 24, 36, 72],
    [73], [2, 37, 74], [3, 5, 15, 25, 75], [2, 4, 19, 38, 76], [7, 11, 77],
    [2, 3, 6, 13, 26, 39, 78], [79], [2, 4, 5, 8, 10, 16, 20, 40, 80],
    [3, 9, 27, 81], [2, 41, 82], [83], [2, 3, 4, 6, 7, 12, 14, 21, 28, 42, 84],
    [5, 17, 85], [2, 43, 86], [3, 29, 87], [2, 4, 8, 11, 22, 44, 88], [89],
    [2, 3, 5, 6, 9, 10, 15, 18, 30, 45, 90], [7, 13, 91], [2, 4, 23, 46, 92],
    [3, 31, 93], [2, 47, 94], [5, 19, 95], 
    [2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 96], [97], [2, 7, 14, 49, 98],
    [3, 9, 11, 33, 99], [2, 4, 5, 10, 20, 25, 50, 100]]
    
    temp1 = factors[var1]
    temp2 = factors[var2]
    length = temp1 & temp2
    if length.length > 0
      true
    else
      false
    end
  end
  
  ##############################################################################
  # input: array of product and consumer arrays
  #
  #   [[consumer arrays] , [product arrays]]
  # Index        0                  1
  #
  # consumer array:
  #   [name length, # of vowels]
  # Index   0             1
  #
  # product array:
  #   [product name length, boolean is_even?]
  # Index          0               1
  #
  # output: max sum of all products matched to users with max suitability score
  #
  ##############################################################################
  def discount(array)
    max_ss = 0.0
    array[1].each.with_index do |product, index|
      ss = 0.0
      temp_index = 0.0
      temp_ss = 0.0
      if product[1] == true #if product name is even
        array[0].each.with_index do |customer, inner_index|
          temp_ss = customer[1].to_f * 1.5
          
          if compare_factors?(product[0], customer[0])
            temp_ss *= 1.5
          end
          
          if temp_ss > ss
            ss = temp_ss
            temp_index = inner_index
          end
        end
      else  #product name is odd
        array[0].each.with_index do |customer, inner_index|
          temp_ss = customer[0].to_f - customer[1].to_f
          if compare_factors?(product[0], customer[0])
            temp_ss *= 1.5
          end
            
          if temp_ss > ss
            ss = temp_ss
            temp_index = inner_index
          end
        end
      end
      max_ss += ss.to_f
      array[0][temp_index] = [0, 0]
    end
    
    max_ss.round(2)
  end
  
  def discountx(array)
    temp_sum = 0
    return_sum = 0
      (0..1000).each do |x|
        temp_sum = discount(array)
        if temp_sum > return_sum
          return_sum = temp_sum
        end
      end
    #return_sum
    return discount(array)
  end
  
  # Compute modulo of two string of two numbers "N, M"
  def modulo(string)
    #temp_array[0] = p     temp_array[1] = q
    temp_array = string.split(",")
    product_array = []
    temp_string = ""
    
    # Produce the array of c*q
    (1..10).each do |x|
      product_array << x * temp_array[1].to_i
    end
    
    temp_array[0].each_char do |char|
      temp_string << char
      if temp_string.to_i < temp_array[1].to_i
        next
      else
        product_array.each.with_index do |product, inner_index|
          if product < temp_string.to_i
            next
          elsif product == temp_string.to_i
            temp_string = ""
            break
          else
            temp_string = (temp_string.to_i - product_array[inner_index - 1]).to_s
            break
          end
        end
      end
    end
    return temp_string.to_i
  end
  
  # Creates a 2D array
  # Marks cells with sums < 20 as unvisited
  def init_graph()
    map = []
    temp_map = []

    
    (0..999).each do |x|
      temp_map = []
      (0..999).each do |y|
        if sum_ints(x, y) < 20
          temp_map << false
        else
          temp_map << true
        end
      end
      map[x] = temp_map
      
    end
    return map
  end
  
  def grid_walkx(graph, coordinate)
    x = coordinate[0]
    y = coordinate[1]
    graph[x][y] = true
    right = [graph, 0]
    up = [graph, 0]
    left = [graph, 0]
    down = [graph, 0]
    
    if graph[x + 1][y] == true && graph[x][y + 1] == true &&
       graph[x][y - 1] == true && graph[x - 1][y] == true
       return [graph, 1]
    else
      if graph[x + 1][y] == false
        right = grid_walkx(graph, [x + 1, y])
        graph = right[0]
      end
      
      if graph[x][y + 1] == false
        up = grid_walkx(graph, [x, y + 1])
        graph = up[0]
      end
      
      if graph[x][y - 1] == false
        down = grid_walkx(graph, [x, y - 1])
        graph = down[0]
      end
      
      if graph[x - 1][y] == false
        left = grid_walkx(graph, [x - 1, y])
        graph = left[0]
      end
    end
    sum = right[1] + left[1] + up[1] + down[1]
    return [graph, sum]
  end
  
  def grid_walk()
    graph = init_graph()
    temp_save = [[0,0]]
    count = 0
    x = 0
    y = 0
    until temp_save == []
      coordinates = temp_save.pop
      x = coordinates[0]
      y = coordinates[1]
      graph[x][y] = true
      count += 1
      
      if graph[x - 1][y] == false
        temp_save << [x - 1, y]
        graph[x - 1][y] = true
      end
      
      if graph[x][y - 1] == false
        temp_save << [x, y - 1]
        graph[x][y - 1] = true
      end
      
      if graph[x][y + 1] == false
        temp_save << [x , y + 1]
        graph[x][y + 1] = true
      end
      
      if graph[x + 1][y] == false
        temp_save << [x + 1, y]
        graph[x + 1][y] = true
      end
      
    end
    return count
  end
  
  def sum_ints(intx, inty)
    temp_sumx = 0
    temp_sumy = 0
    while intx > 0
      temp_sumx += intx.abs % 10
      intx /= 10
    end
    
    while inty > 0
      temp_sumy += inty.abs % 10
      inty /= 10
    end
    
    return temp_sumx + temp_sumy
  end
  
  def string_list(input_string)
    temp_array = input_string.split(",")
    string_length = temp_array[0].to_i
    characters = temp_array[1].chomp
    characters.each_char.with_index do |x, index|
        for y in ((index + 1)..characters.length - 1)
            if characters[index] == characters[y]
               characters[y] = " " 
            end
        end
    end
    characters.chomp!
    temp_array = []
    characters.each_char do |y|
      temp_array << y
    end
    
    return perms(string_length, temp_array).join(",")
  end
  
  def perms(max_length, character_array)
    all = [""]
    current_array = all.clone
    1.upto(max_length) do |iteration|
      next_array = []
      current_array.each do|string|
        character_array.each do |c|
          value = string + c
          next_array.insert next_array.length, value
          all.insert all.length, value
        end
      end
      current_array = next_array
    end
    all.delete_if { |string| string.length < max_length }
  end
  
  def difference(input_array)
    jobs = input_array.shift
    temp_array = []
    #input_array.sort! { |a,b| a[0] - a[1] <=> b[0] - b[1]}
    input_array.sort_by! { |i| [i[0] - i[1], i[0]]}.reverse!
    sum = 0
    completion_time = 0
    input_array.each.with_index do |pair, index|
      completion_time += pair[1]
      sum = sum + pair[0] * completion_time
    end
    return sum
  end
  
    def ratio(input_array)
    jobs = input_array.shift
    temp_array = []
    #input_array.sort! { |a,b| a[0] - a[1] <=> b[0] - b[1]}
    input_array.sort_by! { |i| [(i[0].to_f / i[1].to_f), i[0]]}.reverse!
    sum = 0
    completion_time = 0
    input_array.each.with_index do |pair, index|
      completion_time += pair[1]
      sum = sum + pair[0] * completion_time
    end
    return sum
  end
  
  #PROBLEM
#--------
#You have a string of words and digits divided by comma. 
#Write a program which separates words with digits. 
#You shouldn't change the order elements. 

  def separate_words(line) 
  	
  	$numbers = []
  	$myString = ""
  	$FIRST = true
	
  	#get the words
  	line.split(",").each do |i|
  		if (i =~ /[A-Za-z]/)
  			if ($FIRST)
  				$FIRST = false
  				$myString += "#{i}"
  			else 
  				$myString += ",#{i}"
  			end
  		else
  			$numbers.push(i)
  		end
  	end
  	
  	if ($myString.to_s.strip.length == 0)
  		puts line	# Just numbers so print line
  	else 
  		$FIRST = true
  		$numbers.each do |i|
  			if (i == $numbers.first)
  				$myString += "|#{i}"				
  			elsif (i == $numbers.last)
  				$myString += ",#{i}"
  				puts $myString	
  			else 
  				$myString += ",#{i}"
  			end
  		end 
  	end
  end
  
  
  #accepts a string "main_string,sub_string"
  #returns true if the main_string contains the sub_string
  #returns false otherwise
  def string_search(input_string)
    temp_array = input_string.chomp.split(",")
    sub_string = temp_array[1]
    main_string = temp_array[0]
    sub_count = 0
    main_count = 0
    check_string = ""
    seq_check = false
    escaped = false
 
    while main_count <= main_string.length - 1
    
      if sub_string[sub_count] == '\\'
        if sub_string[sub_count + 1] == '*'
          escaped = true
          sub_count += 1
          next
        end
      end
        
    
      if sub_string[sub_count] == "*"
        if escaped == true && main_string[main_count] == sub_string[sub_count]
          check_string += "\\*"
          sub_count += 1
        elsif escaped == false
          seq_check = false
          check_string += "*"
          sub_count += 1
        end
        
      elsif main_string[main_count] != sub_string[sub_count] && seq_check == true
        sub_count = 0
        check_string = ""
        seq_check = false
        
      elsif main_string[main_count] == sub_string[sub_count] || seq_check == true
        
        if sub_count == 0
          if sub_string.length == 1
            return true
          end
          seq_check = true
        elsif sub_count == sub_string.length - 1
          seq_check = false
        end
        
        check_string += main_string[main_count]
        sub_count += 1


      end
      main_count += 1
    end
    if check_string == sub_string
      return true
    else
      false
    end
    
  end

  def cluster_max(current_clusters, min_clusters, graph)
    min_array = []
    while current_clusters > min_clusters
      current_clusters -= 1
      min_array = min_distance(graph)
      graph = merge_clusters(min_array[0], min_array[1], graph)
    end
    return min_distance(graph)[2]
  end
  
  def min_distance(graph)
    min_dist = Float::INFINITY
    saved_index = 0
    graph.each.with_index do |x, index|
      if x[2] < min_dist
        saved_index = index
        min_dist = x[2]
      end
    end
    return graph.delete_at(saved_index) #removes the index to be merged
  end
  
  def max_distance(graph)
    max_dist = 0
    saved_array = []
    graph.each.with_index do |x, index|
      if x[2] > max_dist
        saved_array = x
        max_dist = x[2]
      end
    end
    return max_dist
  end
  
  def merge_clusters(initial_cluster, to_merge_cluster, graph)
    graph.each.with_index do |x, index|
      if x[0] == to_merge_cluster
        graph[index][0] = initial_cluster
      elsif x[1] == to_merge_cluster
        graph[index][1] = initial_cluster
      end
    end
    return graph.delete_if { |x| x[0] == x[1] }
  end

end
