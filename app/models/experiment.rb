class Experiment < ActiveRecord::Base
    before_create :set_previous_save_state
    before_update :player_turn, :computer_turn
    validates :save_state, presence: true
    
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
          @previous = self.previous_save_state
          inc = 0
          temp_string = ""
          @saved_string = ""
          @max_flip = 0
          temp_save = Experiment.new
          temp_save = current.clone
          temp_count = 0
          saved_count = 0

          temp_save.each_char do |x|
            temp_string = temp_save.clone
              if check_adjacent(temp_save, inc) == true && x == "0"
                  
                 temp_string[inc] = "3"
                  
                 temp_string = flip_pieces(temp_string, false)
                  
                  temp_count = temp_string.count('2')

                  if temp_count > @max_flip
                    @saved_string = temp_string
                    @max_flip = temp_count
                    saved_count = inc
                  end

              end
              
              inc += 1
          end

          self.save_state = @saved_string
          #update_save_states
          
      end
    
      def update_save_states
        @save_state = self.save_state
        self.previous_save_state = @save_state 
      end
      
      def flip_pieces(string, boolean=true)
          #saves the index of the player's move
          string_index = string.index('3')
          current = string.clone
          
          #find row & flip pieces
          @row = find_row(current, string_index)
          @row = flip_substring(@row, boolean)
          
          #create collumn
          @collumn = find_collumn(current, string_index)
          @collumn = flip_substring(@collumn, boolean)
          
          #create positive_diagonal
          @positive_diagonal = positive_diagonal(current, string_index)
          @positive_diagonal = flip_substring(@positive_diagonal, boolean)
          
          #create negative_diagonal
          @negative_diagonal = negative_diagonal(current, string_index)
          @negative_diagonal = flip_substring(@negative_diagonal, boolean)
          
        
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
          
          #self.save_state = @current
          
          
          return current
      end
      

      
      def check_adjacent(str, index)
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
              if x != "0"
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
