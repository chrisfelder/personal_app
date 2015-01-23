module ExperimentsHelper
      
  def multiples_of_three_and_five(int)
    sum = 0
    for i in 0..int 
      if i % 3 == 0 || i % 5 == 0
        sum += i
      end
    end
    return sum
  end
  
  def sum_even_fibonacci(max)
    fibonacci = 1
    last_fib = 1
    temp_fib = 0
    sum = 0
    while fibonacci < max do
      if fibonacci % 2 == 0
        sum += fibonacci
      end
      temp_fib = fibonacci
      fibonacci += last_fib
      last_fib = temp_fib
    end
    return sum
  end
  
  def largest_prime_factor(int)
    if int == 1
      return 1
    end
    i = 2
    array = []
    
    while i <= int
      if int % i == 0
        array << i
        int = int/i
        i = 2
      else
        i += 1
      end
    end
    return array
  end
  
  def palindrome(x, y)
    product = 0
    reverse_product = 0
    product_save = []
    product_save[0] = 0
    
    for i in 1..x
      for j in 1..y
        product = i * j
        reverse_product = reverse(product)
        if product == reverse_product && product > product_save.max  
          product_save[0] = product
        else
        end
      end
    end
    return product_save
    
  end
  
  def reverse(int)
    x = int
    y = 0
    
    while x > 0 do
      y = y * 10
      y = y + (x % 10)
      x = x / 10
    end
    return y
  end
  
  def smallest_multiple(int)
    count = 2
    array = []
    temp_multiple = 0
    temp_count = 0
    multiple_array = []
    for i in 2..int
      array << i
    end
    
    while count <= int
      array.each.with_index do |char, index|
        if char == 1
          next
        elsif char % count == 0
          temp_count += 1
          temp_multiple = count
          array[index] = char/count
        end
      end
      
      if temp_count > 0
        multiple_array << temp_multiple
        temp_count = 0
        count = 2
      else
        count += 1
      end
    end
    return multiple_array
  end
  
end
