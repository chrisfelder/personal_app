module TracksHelper
    
  # Create an array of horizontal eye position data from the input data
  def screen_data(input_string)
    temp_data = input_string.scan(/^\s+0+[\s\d.\d]+$/)
    temp_data = temp_data[0].split("\n")
    
    temp_data.each.with_index do |string, index|
       temp_data[index] = string.scan(/\d+\.\d+/).first.to_f
    end
    temp_data
  end
  
#  def look_firstx
#    
#    left_array = []
#    right_array = []
#    init_position = 0
#    screen_data.each.with_index do |position, index|
#      if position == 0
#        next  
#      end
#      
#      if index < 120
#        init_position += position
#      elsif index == 120
#        init_position = init_position / 120
#      else
#        if position < init_position - 10
#          left_array << [index, position]
#        elsif position > init_position + 10
#          right_array << [index, position]
#        end
#      end
#    end
#    return [init_position.round(2), left_array, right_array]
#  end
  
  def look_first(array, num_of_trials, trial_time, calibration, recalibration)
    #convert seconds to indices
    recalibration *= 60   
    calibration *= 60
    trial_time *= 60
    
    #variables to track trial initiation and termination
    trial_state = false
    trial_count = 0
    next_transition = 0
    midpoint = 0
    
    #variables used to calculate the initial average midpoint
    init_midpoint_sum = 0
    init_midpoint_count = 0
    
    #variables used for calculating stdev
    stdev_array = []
    
    #variables to copmute final count
    left_count = 0
    right_count = 0
    
    # true = left, false = right
    looked_first_array = []
    time_looked_array = []
    
    array.each.with_index do |position, index|
      #prevents blinking from disrupting results
      if position == 0.0 
        next
      end
      

      if index < calibration
        init_midpoint_count += 1
        init_midpoint_sum += position
        next
      elsif index == calibration
        midpoint = init_midpoint_sum / init_midpoint_count
        next_transition = calibration
        
        (0..20).each do |x|
          stdev_array << array[index - x]
        end
        
        next
      end
      
      # Adjust stdev_array for the new position
      stdev_array.shift        #removes first element
      stdev_array << position  #adds the current position
      stdev = stdev(stdev_array)
      
      
      # Begin new trial
      if index > next_transition && stdev > 3.0 && trial_state == false
        next_transition = index + trial_time - 10
        trial_state = true
        trial_count += 1
        if position < midpoint
          looked_first_array << "Left"
        else
          looked_first_array << "Right"        
        end
      # During each trial
      elsif index < next_transition && trial_state == true
        if position < midpoint
          left_count += 1
        else #position >= midpoint
          right_count += 1
        end
      # End trial, Begin recalibration
      elsif index >= next_transition && stdev < 1.0 && trial_state == true
        midpoint = position
        trial_state = false
        next_transition = index + recalibration - 10
        time_looked_array << [sprintf('%.2f', left_count.to_f / 60.0),
                              sprintf('%.2f', right_count.to_f / 60.0)]
        left_count = 0
        right_count = 0
        
        if trial_count == num_of_trials
          break
        end

      end
    end  #array for loop
    
    return [time_looked_array, looked_first_array]
  end
  
  def stdev(array)
    n = array.length
    array.map!(&:to_f)
    mean = array.reduce(&:+) / n
    sum_sqr = array.map { |x| x * x}.reduce(&:+)
    Math.sqrt((sum_sqr - n * mean * mean) / (n - 1)).round(2)
  end
  
  def process_table(array)
    returned_array = []
    (1..array[1].length).each.with_index do |x, index|
      returned_array[index] = [x]
    end
    array[1].each.with_index do |y, index|
      returned_array[index] << y
    end
    array[0].each.with_index do |z, index|
      z.each_with_index do |a, inner_index|
        returned_array[index] << a
      end
    end
    returned_array
  end
end
