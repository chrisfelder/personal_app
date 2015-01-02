class Experiment < ActiveRecord::Base
    before_create :set_previous_save_state
    before_update :player_turn, :test_area, :computer_turn 
    
    protected
    
      def test_area
          @test_string = self.save_state
          @index = self.save_state.index('3')
          #if adjacent_piece?(@test_string, @index)
          #    self.save_state = "012012"
          #else
          #    self.save_state = "0000000"
          #end
          
          
          
      end
      
      def set_previous_save_state
          self.previous_save_state = "0" * 27 + "12" + "0" * 6 + "21" + "0" * 27
      end
    
      def update_save_states
        @save_state = self.save_state
        self.previous_save_state = @save_state 
      end
      
      def flip_pieces(boolean=true)
          #saves the index of the player's move
          @index = self.save_state.index('3')
          @current = self.save_state
          @temp = Experiment.new
          @temp.save_state = @current
          
          
          #find row & flip pieces
          @row = find_row(@current, @index)
          @row = flip_substring(@row, boolean)
          
          #create collumn
          @collumn = find_collumn(@current, @index)
          @collumn = flip_substring(@collumn, boolean)
          
          #create positive_diagonal
          @positive_diagonal = positive_diagonal(@current, @index)
          @positive_diagonal = flip_substring(@positive_diagonal, boolean)
          
          #create negative_diagonal
          @negative_diagonal = negative_diagonal(@current, @index)
          @negative_diagonal = flip_substring(@negative_diagonal, boolean)
          
        
          #update the board_state
          @current = put_row(@current, @row, @index)
          @current = put_collumn(@current, @collumn, @index)
          @current = put_positive_diagonal(@current, @positive_diagonal, @index)
          @current = put_negative_diagonal(@current, @negative_diagonal, @index)
          
          #sets the last played piece to a computer or player piece
          if boolean == true
            @current.gsub! '3', '1'
          else
            @current.gsub! '3', '2'
          end
          
          #self.save_state = @current
          
          
          return @current
      end
      
      def player_turn
          @current = self.save_state
          @current = flip_pieces(true)
          self.save_state = @current
      end
      
      def computer_turn
          @current = self.save_state
          @previous = self.previous_save_state
          @count = 0
          @current.each_char do |x|
              if adjacent_piece?(@current, @count) && x == "0"
                  @current[@count] = "3"
                  flip_pieces(false)
                  break
              end
              @count += 1
          end
          
          self.save_state = @current
          update_save_states
          
      end
      
      def adjacent_piece?(str, index)
          @temp_str = ""
          @index = index - 9
          @TL = str[@index]
          @T  = str[index - 8]
          @TR = str[index - 7]
          @L  = str[index - 1]
          @R  = str[index + 1]
          @BL = str[index + 7]
          @B  = str[index + 8]
          @BR = str[index + 9]
          @temp = true
          if index == 0
            @temp_str = @R + @B + @BR
          elsif index == 7
            @temp_str = @L + @B + @BL
          elsif index == 56
            @temp_str = @T + @TR + @R
          elsif index == 63
            @temp_str = @TL + @T + @L
          elsif index / 8 == 0 
            @temp_str = @L + @R + @BL + @B + @BR
          elsif index % 8 == 0
            @temp_str = @T + @TR + @R + @B + @BR
          elsif index % 8 == 7
            @temp_str = @TL + @T + @L + @BL + @B
          elsif index / 8 == 7
            @temp_str = @TL + @T + @TR + @L + @R
          else
            @temp_str = @TR + @T + @TL + @L + @R + @BL + @B + @BR
          end
          
          @temp_str.each_char do |x|
              if x != "0"
                return true
              end
          end
          
          return false
            
      end
      
      def positive_diagonal(str, index)
        @diagonal = index % 8 + index / 8
        @count = 0
        @temp_str = ""
        str.each_char do |x|
            if (@count % 8 + @count / 8) == @diagonal
                @temp_str << x
            end
            @count += 1
        end
        return @temp_str
      end
      
      def put_positive_diagonal(save_string, changed_diagonal, index)
          @diagonal = index / 8 + index % 8
          @save_count = 0
          @changed_count = 0
          
          save_string.each_char do |x|
              if (@save_count % 8 + @save_count / 8) == @diagonal
                  save_string[@save_count] = changed_diagonal[@changed_count]
                  @changed_count += 1
              end
              @save_count += 1
          end
      end
      
      def negative_diagonal(str, index)
        @index_row = index / 8
        @index_collumn = index % 8
        until @index_row == 0 or @index_collumn == 0
          @index_row -= 1
          @index_collumn -= 1
        end
        @count = 0
        @temp_str = ""
        str.each_char do |x|
            if (@count/8 == @index_row && @count % 8 == @index_collumn)
                @temp_str << x
                @index_row += 1
                @index_collumn += 1
            end
            @count += 1
        end
        return @temp_str
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
          @count = 0
          @temp_str = ""
          
          str.each_char do |x|
              if @count/8 == @row
                  @temp_str << x
              end
              @count += 1
          end
          return @temp_str

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
          @temp_str = ""
          @collumn = index % 8
          @count = 0
          str.each_char do |x|
            if @count % 8 == @collumn
                @temp_str << x
            end
            @count += 1
          end
          return @temp_str
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
