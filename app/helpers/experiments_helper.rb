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
    if length == 1
      return array
    else
      pivot = choose_pivot(array, length)
      array = partition(array, 0, length)
      puts "entering Left"
      array[0..(length / 2 - 1)] = quick_sort(array[0..(length / 2 - 1)], length / 2)
      puts "entering right"
      #array[(length / 2)..(length - 1)] = quick_sort(array[(length / 2)..(length - 1)], length / 2)
      #recursively sort 1st part
      #recursively sort 2nd part
    end
    return array
  end
  
  def choose_pivot(array, length)
    return array[0]
  end
  
  # 3 8 2 5 1 4 7 6
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
end
