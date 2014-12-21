module GamestoresHelper
    def find_characters
      @user = User.find(params[:user_id])
      @characters = @user.characters
      @character_array = []
      @characters.each do |f|
        @temp = [f.name, f.id]
        @character_array.push(@temp)
      end
      return @character_array
    end
end
