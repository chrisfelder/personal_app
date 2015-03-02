module TracksHelper
    
  # Create an array of horizontal eye position data from the input data
  def screen_data
    temp_data = @track.input.scan(/^\s+0+[\s\d.\d]+$/)
    temp_data = temp_data[0].split("\n")
    
    temp_data.each.with_index do |string, index|
       temp_data[index] = string.scan(/\d+\.\d+/).first.to_f
    end
    temp_data
  end
  
  def look_first
    left_array = []
    right_array = []
    init_position = 0
    screen_data.each.with_index do |position, index|
      if index < 120
        init_position += position
      elsif index == 120
        init_position = init_position / 120
      else
        if position < init_position - 10
          left_array << [index, position]
        elsif position > init_position + 10
          right_array << [index, position]
        end
      end
    end
    return [init_position.round(2), left_array, right_array]
  end
end
