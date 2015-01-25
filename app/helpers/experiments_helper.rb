module ExperimentsHelper
  
    require "prime"

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
  
  def variance(x, y)
    sum = 0
    sum_of_squares = 0
    for i in x..y
      sum += i
      sum_of_squares = sum_of_squares + i * i
    end
     sum ** 2 - sum_of_squares
  end
  
  #finds the nth prime number below 1 * 10^12
  def nth_prime(int)
    bool = true
    prime_array = [2]
    
    (3..1000000000000).step(2) do |x|
      bool = true
      prime_array.each.with_index do |char, index|
        if x % char == 0
          bool = false
          break
        elsif index > Math.sqrt(prime_array.length)
          break
        end
      end
      
      if bool == true
        prime_array << x
        if prime_array.length == int
          return prime_array.last
        end
      end
      
    end
  end
  
  def largest_product(length)
    temp_series = 7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450

    subseries = 0
    max_product= 0
    
    while temp_series > 0
    
      if temp_series % 10 == 0 && subseries != 0
          temp_product = subseries_product(subseries, length)
        
          if subseries > 10 ** length && temp_product > max_product
            max_product = temp_product
          end
          
        subseries = 0
        
      else
        subseries = subseries * 10
        subseries = subseries + (temp_series % 10)
      end
      
      temp_series = temp_series / 10
    end
    
    return max_product
  end

  def subseries_product(subseries, length)
    max_product = 0
    while subseries > 0
      temp_product = int_product(subseries % (10 ** length))
      if temp_product > max_product
        max_product = temp_product
      end
      subseries = subseries / 10
    end
    return max_product
  end

  def int_product(length)
    product = 1
    
    while length > 0
      product = product * (length % 10)
      length = length / 10
    end
    return product
  end

  def pythagorean_triplet(int)
    temp_array = (1..(int / 2)).to_a
    a = temp_array.find { |z| (int * (int / 2 - z) % (int - z)).zero? }
    
    b = int * (int / 2 - a) / ( int - a)
    
    return a * b * (int - a - b)

  end

  
    #finds the nth prime number below 1 * 10^12
  def prime_sum(int)
    bool = true
    prime_array = [2]
    
    (3..int).step(2) do |x|
      bool = true
      prime_array.each.with_index do |char, index|
        if x % char == 0
          bool = false
          break
        elsif index > Math.sqrt(prime_array.length)
          break
        end
      end
      
        if bool == true
          prime_array << x
        end
      
    end
    
    return prime_array.inject(:+)
  end
  
  # Uses Ruby's Prime Class to return the sum of all primes up to an integer
  def prime_sumx(int)
    a = Prime.take_while { |x| x < int }
    return a.inject(:+)
  end

end
