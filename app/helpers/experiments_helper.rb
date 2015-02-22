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
  #
  def shortestpath(graph, source, verts)
    return graph
  end
end
