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
  
  
end
