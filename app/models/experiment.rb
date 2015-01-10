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
    
    def val_table(int, boolean = true)
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
    
    def frontier_tiles(board, boolean)
      board.each_char.with_index do |char, index|
        #check for player's piece, add to player count, add val_table to d
        #if opponent piece add to opponent count, subtract val_table to d
        #if "0" then 
      end
    end
    
    def mobility_score(board, boolean)
      score = 0
      my_discs = list_children(board, boolean).count
      opponent_discs = list_children(board, !boolean).count
      
      if(my_discs > opponent_discs)
        return ((100.0 * my_discs)/(my_discs + opponent_discs)).to_int
      elsif (my_discs < opponent_discs)
       return ((100.0 * -1 * opponent_discs)/(my_discs + opponent_discs)).to_int
      else
        return score
      end
      
    end
    
    def evaluation_function(board, boolean)
      if boolean == true 
        my_piece = "1"
        opp_piece = "2"
      else
        my_piece = "2"
        opp_piece = "1"
      end
      
      my_discs = 0
      opponent_discs = 0
      total_disc_score = 0
      
      disc_value_sum = 0
      temp_board = board.clone
      temp_board.each_char.with_index do |char, index|
        if char == my_piece
          disc_value_sum += val_table(index)
          my_discs += 1
        elsif char == opp_piece
          disc_value_sum -= val_table(index)
          opponent_discs += 1
        end
      end
      
      if my_discs > opponent_discs
        total_disc_score = (100 * my_discs)/(my_discs + opponent_discs)
      elsif my_discs < opponent_discs
        total_disc_score = (100 * opponent_discs)/(my_discs + opponent_discs)
      end
      
      score = (corner_score(temp_board, boolean) * 800) + 
              (mobility_score(temp_board, boolean) * 79) + 
              (corner_closeness(temp_board, boolean) * 380) +
              (total_disc_score * 10) +
              (disc_value_sum * 10)
              
      return score
    end
    
    def corner_score(board, boolean)
      my_pieces = 0 
      opponent_pieces = 0
      board_state = [0, 7, 56, 63]

      if boolean == true 
        my_piece = "1"
        opp_piece = "2"
      else
        my_piece = "2"
        opp_piece = "1"
      end

      board_state.each do |index|
        if(board[index] == my_piece)
          my_pieces += 1
        elsif (board[index] == opp_piece)
          opponent_pieces += 1
        end
      end
      
       return 25 * (my_pieces - opponent_pieces)
    end
    
    def corner_closeness(board, boolean)
      my_count = 0
      opponent_count = 0
      
      if boolean == true
        my_discs = "1"
        opponent_discs = "2"
      else
        my_discs = "2"
        opponent_discs = "1"
      end
      
      if board[0] = "0"
        [1, 8, 9].each do |x|
          if board[x] == my_discs
            my_count += 1
          elsif board[x] == opponent_discs
            opponent_count += 1
          end
        end
      end
      
      if board[7] = "0"
        [6, 14, 15].each do |x|
          if board[x] == my_discs
            my_count += 1
          elsif board[x] == opponent_discs
            opponent_count += 1
          end
        end
      end
      
      if board[56] = "0"
        [48, 49, 57].each do |x|
          if board[x] == my_discs
            my_count += 1
          elsif board[x] == opponent_discs
            opponent_count += 1
          end
        end
      end
      
      if board[63] = "0"
        [54, 55, 62].each do |x|
          if board[x] == my_discs
            my_count += 1
          elsif board[x] == opponent_discs
            opponent_count += 1
          end
        end
      end
      
      score = (-12.5 * (my_count - opponent_count)).to_int
      return score
    end
    
    def computer_turn_medium(board, depth, boolean)
        score = -1000000000
        temp_score = 0
        children = []
        moves = []
        #scores = []
        
        children = list_children(board, boolean)
        #remember to add back the condition that the board is empty to return
        if children == [] then return board end
        
        children.each do |x|
          temp_score = minimax(x, depth + 1, !boolean)
          #scores << temp_score
          if temp_score > score
            moves = []
            score = temp_score
            moves << x
          elsif temp_score == score
            moves << x
          end
        end
        moves_length = moves.count
        random_move = rand(0..moves_length - 1)
        return moves[random_move]
    end
    
    def minimax(board, depth, boolean)
        boolean == true ? temp_score = "1": temp_score = "2"
        children = []
        
        if board.count("0") == 0 || depth == 2
          #change this to return the static evaluation function
          #puts "This is the board count:" + board.count(temp_score).to_s
          #return board.count(temp_score)
          return evaluation_function(board, boolean)
        end
        
        #Find all children of the current board state
        children = list_children(board, boolean)
        #if(max's turn)
        if boolean==false
          score = -1000000000
          children.each do |x|
            #puts x
            temp = minimax(x, depth + 1, true)
            if temp > score
              score = temp
            end
          end
          #puts "this is the returned score from max" + score.to_s
          return score
        #return maximal score of calling minimax on all the children
        #else (min's turn)
        else
          score = 10000000000
          children.each do |x|
            #puts x
            temp = minimax(x, depth + 1, false)
            if temp < score
              score = temp
            end
          end
          #puts "this is the returned score from min" + score.to_s
          return score
        #return minimal score of calling minimax on all the children
        end
    end
      
    protected
    
      def set_previous_save_state
          self.previous_save_state = "0" * 27 + "12" + "0" * 6 + "21" + "0" * 27
      end
      
      def player_turn
          current = self.save_state
          if current.count("3") == 0
            self.save_state = current
          else
            current.each_char.with_index do |char, index|
              if char == "4" then current[index] = "0" end
            end
            current = flip_pieces(current, true)
            self.save_state = current
          end
      end
      
      def computer_turn
        current = self.save_state
        temp_save = Experiment.new
        temp_save = current.clone
        temp_save = computer_turn_medium(temp_save, 0,false)
        #temp_save = computer_turn_easy(temp_save)
        index_array = list_children(temp_save, true, true)
        index_array.each do |x|
          temp_save[x] = "4"
        end
        self.save_state = temp_save
      end
      
      def computer_turn_easy(board)
          temp_string = ""
          @saved_string = board.clone
          @max_flip = 0
          temp_save = Experiment.new
          temp_save = board.clone
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
          return @saved_string
      end
      
      #checks for valid moves and returns an array of flipped board states
      def list_children(board, boolean = true, spaces = false)
        temp_board = board.clone
        boolean == true ? my_discs = "1": my_discs = "2"
        move_array = []
        move_spaces = []
        temp_board.each_char.with_index do |char, index|
          temp_string = board.clone
            if check_adjacent(temp_string, index, boolean) == true && char == "0"
              temp_string[index] = "3"
              temp_string = flip_pieces(temp_string, boolean)
                if temp_string.count(my_discs) > board.count(my_discs) + 1
                  move_array << temp_string
                  move_spaces << index
                end
            end
        end
        spaces == true ?  move_spaces : move_array
      end
      
      def flip_pieces(string, boolean=true)
          #saves the index of the player's move
          string_index = string.index('3')
          current = string.clone
          
          #find row & flip pieces
          @row = find_row(current, string_index)
          @row = flip(@row, boolean)
          
          #create collumn
          @collumn = find_collumn(current, string_index)
          @collumn = flip(@collumn, boolean)
          
          #create positive_diagonal
          @positive_diagonal = positive_diagonal(current, string_index)
          @positive_diagonal = flip(@positive_diagonal, boolean)
          
          #create negative_diagonal
          @negative_diagonal = negative_diagonal(current, string_index)
          @negative_diagonal = flip(@negative_diagonal, boolean)
          
        
          #update the board_state
          current = put_row(current, @row, string_index)
          current = put_collumn(current, @collumn, string_index)
          current = put_positive_diagonal(current, @positive_diagonal, string_index)
          current = put_negative_diagonal(current, @negative_diagonal, string_index)
          
          #sets the last played piece to a computer or player piece
          if boolean == true
            current.gsub! '3', '1'
          else
            current.gsub! '3', '2'
          end

          return current
      end
      
      def check_adjacent(str, index, boolean = true)
          boolean == true ? player = "2": player = "1"
          temp_str = ""
          @TL = str[index - 9]
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

      def flip(str, boolean=true)
        if boolean == true
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

end
