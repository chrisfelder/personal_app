module ExperimentsHelper
      
      
      def flip_substring(str, boolean=true)
          if boolean == true
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
