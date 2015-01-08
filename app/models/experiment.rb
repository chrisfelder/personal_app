class Experiment < ActiveRecord::Base
    require 'benchmark'
    before_create :set_previous_save_state
    before_update :player_turn, :computer_turn
    validates :save_state, presence: true

    def method_benchmark
      n = 50000
      Benchmark.bm do |x|
        x.report { n.times do; flip("213", false); end }
        x.report { n.times do; flip_substring("213", false); end }
      end
    end
    
    def val_table(int, booleon = true)
      temp_array1= [99, -8, 8, 6, 6, 8, -8, 99]
      temp_array2= [-8, -24, -4, -3, -3, -4, -24, -8]
      temp_array3= [8, -4, 7, 4, 4, 7, -4, 8]
      temp_array4= [6, -3, 4, 0, 0, 4, -3, 6]
      total_array = [temp_array1, temp_array2, temp_array3, temp_array4,
                     temp_array4, temp_array3, temp_array2, temp_array1]
      value_table = []
        total_array.each do |x|
         x.each do |y|
          value_table << y
        end
      end
      
      return value_table[int]
    end
    
      def minimax(board, depth, booleon)
        booleon == true ? temp_score = "1": temp_score = "2"
        children = []
        
        if board.count("0") == 0 || depth == 2
          #change this to return the static evaluation function
          puts "This is the board count:" + board.count(temp_score).to_s
          return board.count(temp_score)
        end
        
        #Find all children of the current board state
        children = list_children(board, booleon)
        
        #if(max's turn)
        if booleon==false
          score = -100
          children.each do |x|
            puts x
            temp = minimax(x, depth + 1, true)
            puts "this is the max temp" + temp.to_s
            if temp > score
              score = temp
            end
          end
          puts "this is the returned score from max" + score.to_s
          return score
        #return maximal score of calling minimax on all the children
        #else (min's turn)
        else
          score = 100
          children.each do |x|
            puts x
            temp = minimax(x, depth + 1, false)
            puts "this is the min temp" + temp.to_s
            if temp < score
              score = temp
            end
          end
          puts "this is the returned score from min" + score.to_s
          return score
        #return minimal score of calling minimax on all the children
        end
      end
      
    protected
    
      def test_area
          @test_string = self.save_state
          @index = self.save_state.index('3')

      end
      
      def set_previous_save_state
          self.previous_save_state = "0" * 27 + "12" + "0" * 6 + "21" + "0" * 27
      end
      
      def player_turn
          current = self.save_state
          current = flip_pieces(current, true)
          self.save_state = current
      end
      
      def computer_turn
          current = self.save_state
          temp_string = ""
          @saved_string = current.clone
          @max_flip = 0
          temp_save = Experiment.new
          temp_save = current.clone
          temp_count = 0
          saved_count = 0

          temp_save.each_char.with_index do |char, index|
            temp_string = temp_save.clone
              if check_adjacent(temp_save, index, false) == true && char == "0"
                 temp_string[index] = "3"
                 temp_string = flip_pieces(temp_string, false)
                 temp_count = temp_string.count('2')

                  if temp_count > @max_flip
                    @saved_string = temp_string
                    @max_flip = temp_count
                    saved_count = index
                  end
              end
          end
          self.save_state = @saved_string
      end
      

      def computer_turn_medium(board, depth, booleon)
        current = self.save_state
        temp_string = ""
        @saved_string = current.clone
        @max_flip = 0
        temp_save = Experiment.new
        temp_save = current.clone
        temp_count = 0
        saved_count = 0
        score = 0
        children = []

          temp_save.each_char.with_index do |char, index|
            temp_string = temp_save.clone
              if check_adjacent(temp_save, index, false) == true && char == "0"
                 temp_string[index] = "3"
              end
          end
      end
      

    
      #checks for valid moves and returns an array of flipped board states
      def list_children(board, booleon = true)
        move_array = []
        board.each_char.with_index do |char, index|
          temp_string = board.clone
            if check_adjacent(temp_string, index, booleon) == true && char == "0"
              temp_string[index] = "3"
              temp_string = flip_pieces(temp_string, booleon)
              move_array << temp_string
            end
        end
        return move_array
      end
      
      def update_save_states
        @save_state = self.save_state
        self.previous_save_state = @save_state 
      end
      
      def flip_pieces(string, booleon=true)
          #saves the index of the player's move
          string_index = string.index('3')
          current = string.clone
          
          #find row & flip pieces
          @row = find_row(current, string_index)
          @row = flip(@row, booleon)
          
          #create collumn
          @collumn = find_collumn(current, string_index)
          @collumn = flip(@collumn, booleon)
          
          #create positive_diagonal
          @positive_diagonal = positive_diagonal(current, string_index)
          @positive_diagonal = flip(@positive_diagonal, booleon)
          
          #create negative_diagonal
          @negative_diagonal = negative_diagonal(current, string_index)
          @negative_diagonal = flip(@negative_diagonal, booleon)
          
        
          #update the board_state
          current = put_row(current, @row, string_index)
          current = put_collumn(current, @collumn, string_index)
          current = put_positive_diagonal(current, @positive_diagonal, string_index)
          current = put_negative_diagonal(current, @negative_diagonal, string_index)
          
          #sets the last played piece to a computer or player piece
          if booleon == true
            current.gsub! '3', '1'
          else
            current.gsub! '3', '2'
          end
          
          #self.save_state = @current
          
          
          return current
      end
      

      
      def check_adjacent(str, index, booleon = true)
          booleon == true ? player = "2": player = "1"
          temp_str = ""
          @index = index - 9
          @TL = str[@index]
          @index = index - 8
          @T  = str[@index]
          @index = index - 7
          @TR = str[@index]
          @index = index - 1
          @L  = str[@index]
          @index = index + 1
          @R  = str[@index]
          @BL = str[index + 7]
          @B  = str[index + 8]
          @index = index + 9
          @BR = str[@index]
          @temp = true
          if index == 0
            temp_str = @R + @B + @BR
          elsif index == 7
            temp_str = @L + @B + @BL
          elsif index == 56
            temp_str = @T + @TR + @R
          elsif index == 63
            temp_str = @TL + @T + @L
          elsif index / 8 == 0 
            temp_str = @L + @R + @BL + @B + @BR
          elsif index % 8 == 0
            temp_str = @T + @TR + @R + @B + @BR
          elsif index % 8 == 7
            temp_str = @TL + @T + @L + @BL + @B
          elsif index / 8 == 7
            temp_str = @TL + @T + @TR + @L + @R
          else
            temp_str = @TL + @T + @TR + @L + @R + @BL + @BR + @B 
          end
          
          temp_str.each_char do |x|
              if x == player
                @temp = true
                break
              else
                @temp = false
              end
              
          end
          return @temp
            
      end
      
      def positive_diagonal(str, index)
        @diagonal = index % 8 + index / 8
        @count = 0
        temp_str = ""
        str.each_char do |x|
            if (@count % 8 + @count / 8) == @diagonal
                temp_str << x
            end
            @count += 1
        end
        return temp_str
      end
      
      def put_positive_diagonal(string, changed_diagonal, index)
          @diagonal = index / 8 + index % 8
          @save_count = 0
          @changed_count = 0
          
          string.each_char do |x|
              if (@save_count % 8 + @save_count / 8) == @diagonal
                  string[@save_count] = changed_diagonal[@changed_count]
                  @changed_count += 1
              end
              @save_count += 1
          end
          return string
      end
      
      def negative_diagonal(str, index)
        @index_row = index / 8
        @index_collumn = index % 8
        until @index_row == 0 or @index_collumn == 0
          @index_row -= 1
          @index_collumn -= 1
        end
        @count = 0
        temp_str = ""
        str.each_char do |x|
            if (@count/8 == @index_row && @count % 8 == @index_collumn)
                temp_str << x
                @index_row += 1
                @index_collumn += 1
            end
            @count += 1
        end
        return temp_str
      end
      
      def put_negative_diagonal(save_string, changed_diagonal, index)
          @index_row = index / 8
          @index_collumn = index % 8
          until @index_row == 0 or @index_collumn == 0
            @index_row -= 1
            @index_collumn -= 1
          end
          @save_count = 0
          @changed_count = 0
          save_string.each_char do |x|
              if(@save_count / 8 == @index_row && @save_count % 8 == @index_collumn)
                  save_string[@save_count] = changed_diagonal[@changed_count]
                  @index_row += 1
                  @index_collumn +=1
                  @changed_count += 1
              end
              @save_count += 1
          end
          return save_string
      end
      
      #Accepts a save_state and index, returns the row containing the index.
      def find_row(str, index)
          @row = index / 8
          count = 0
          temp_str = ""
          
          str.each_char do |x|
              if count/8 == @row
                  temp_str << x
              end
              count += 1
          end
          return temp_str

      end
      
      #Accepts an altered row substring and reincoporates it into the save_state.
      def put_row(save_string, changed_row, index)
          @row = index/8
          @save_string_count = 0
          @changed_row_count = 0
          
          save_string.each_char do |x|
              if @save_string_count/8 == @row
                save_string[@save_string_count] = changed_row[@changed_row_count]
                @changed_row_count += 1
              end
              @save_string_count += 1
          end
          return save_string
      end
      
      def find_collumn(str, index)
          temp_str = ""
          @collumn = index % 8
          count = 0
          str.each_char do |x|
            if count % 8 == @collumn
                temp_str << x
            end
            count += 1
          end
          return temp_str
      end
      
      def put_collumn(save_string, changed_collumn, index)
          @collumn = index % 8
          @save_string_count = 0
          @changed_collumn_count = 0
          
          save_string.each_char do |x|
              if @save_string_count % 8 == @collumn
                save_string[@save_string_count] = 
                  changed_collumn[@changed_collumn_count]
                @changed_collumn_count += 1
              end
              @save_string_count += 1
          end
          return save_string
      end

      def flip(str, booleon=true)
        if booleon == true
          if /^\d*[1]2+[3]2+[1]\d*/.match(str)
            temp_array = str.split("3")
            temp_array[0].reverse!
            temp_array.each do |x|
              x.each_char.with_index do |char, index| 
                char == "2" ? x[index] = "1" : break
              end
            end
            temp_array[0].reverse!
            return temp_array[0] + "3" + temp_array[1]
          elsif /^\d*[1]2+[3]\d*/.match(str)
            temp_array = str.split("3")
            temp_array[0].reverse!
            temp_array[0].each_char.with_index do |char, index|
              char == "2" ? temp_array[0][index] = "1" : break
            end
            temp_array[0].reverse!
            if temp_array[1] == nil
              return temp_array[0] + "3"
            else
              return temp_array[0] + "3" + temp_array[1]
            end
          elsif /^\d*[3]2+[1]\d*/.match(str)
            temp_array = str.split("3")
            temp_array[1].each_char.with_index do |char, index|
              char == "2" ? temp_array[1][index] = "1" : break
            end
            if temp_array[0] == nil
              return "3" + temp_array[1]
            else
              return temp_array[0] + "3" + temp_array[1]
            end
          else
            return str
          end
        else  
          if /^\d*[2]1+[3]1+[2]\d*/.match(str)
            temp_array = str.split("3")
            temp_array[0].reverse!
            temp_array.each do |x|
            x.each_char.with_index do |char, index| 
               char == "1" ? x[index] = "2" : break
              end
            end
            temp_array[0].reverse!
            return temp_array[0] + "3" + temp_array[1]
          elsif /^\d*[2]1+[3]\d*/.match(str)
            temp_array = str.split("3")
            temp_array[0].reverse!
            temp_array[0].each_char.with_index do |char, index|
              char == "1" ? temp_array[0][index] = "2" : break
            end
            temp_array[0].reverse!
            if temp_array[1] == nil
              return temp_array[0] + "3"
            else
              return temp_array[0] + "3" + temp_array[1]
            end
          elsif /^\d*[3]1+[2]\d*/.match(str)
            temp_array = str.split("3")
            temp_array[1].each_char.with_index do |char, index|
              char == "1" ? temp_array[1][index] = "2" : break
            end
            if temp_array[0] == nil
              return "3" + temp_array[0]
            else
              return temp_array[0] + "3" + temp_array[1]
            end
          else
            return str
          end
        end
      end
      
      
      def flip_substring(str, booleon=true)
          if booleon == true
            for i in 0..1  
              if str.include? "123"
                str.gsub! '123', '113'
              elsif str.include? "1223"
                str.gsub! '1223', '1113'
              elsif str.include? "12223"
                str.gsub! '12223', "111113"
              elsif str.include? "122223"
                str.gsub! '122223', "111113"
              elsif str.include? "1222223"
                str.gsub! '1222223', "1111113"
              elsif str.include? "12222223"
                str.gsub! '12222223', "11111113"
              elsif str.include? "321"
                str.gsub! '321', "311"
              elsif str.include? "3221"
                str.gsub! '3221', "3111"
              elsif str.include? "32221"
                str.gsub! '32221', "31111"
              elsif str.include? "322221"
                str.gsub! '322221', "311111"
              elsif str.include? "3222221"
                str.gsub! '3222221', "3111111"
              elsif str.include? "32222221"
                str.gsub! '32222221', "31111111"
              end
            end
          else
            for i in 0..1  
              if str.include? "213"
                str.gsub! '213', '223'
              elsif str.include? "2113"
                str.gsub! '2113', '2223'
              elsif str.include? "21113"
                str.gsub! '21113', "22223"
              elsif str.include? "211113"
                str.gsub! '211113', "2222223"
              elsif str.include? "2111113"
                str.gsub! '2111113', "22222223"
              elsif str.include? "21111113"
                str.gsub! '21111113', "22222223"
              elsif str.include? "312"
                str.gsub! '312', "322"
              elsif str.include? "3112"
                str.gsub! '3112', "3222"
              elsif str.include? "31112"
                str.gsub! '31112', "32222"
              elsif str.include? "311112"
                str.gsub! '311112', "322222"
              elsif str.include? "3111112"
                str.gsub! '3111112', "3222222"
              elsif str.include? "31111112"
                str.gsub! '31111112', "32222222"
              end
            end
          end
        return str
      end
      
end
