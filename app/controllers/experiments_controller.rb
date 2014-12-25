class ExperimentsController < ApplicationController
  def new
    @user = User.new
  end

  def forms
    @user = User.new
  end
  
  def reversi
    @board_state = 
      "0120120101201201012012010120120101201201012012010120120101201201"
  end
end
