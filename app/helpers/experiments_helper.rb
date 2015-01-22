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
end
