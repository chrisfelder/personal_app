class ExperimentsController < ApplicationController
  before_action :set_board, only: :update
  
  def index
  end
  
  def new
    @user = User.new
  end
  
  def show
    @experiment = Experiment.find(params[:id])
    @counter = 0
    @board_state = @experiment.save_state
    @test_state = "0120120101201201012012010120120101201201012012010120120101201201"
    @test = 0
  end

  def forms
    @user = User.new
  end
  
  def reversi
    @experiment = Experiment.new
    @counter = 0
    @new_board_state = "0" * 27 + "12" + "0" * 6 + "21" + "0" * 27
    @board_state = "0120120101201201012012010120120101201201012012010120120101201201"
  end
  
  def create
    @experiment = Experiment.new(experiment_params)
    if @experiment.save
      respond_to do |format|
        format.html {redirect_to @experiment}
        format.js
      end
    else
      render 'reversi'
    end
  end
  
  def update
    @experiment = Experiment.find(params[:id])
    if @experiment.update(experiment_params)
      redirect_to @experiment
    else
      render 'reversi'
    end
  end
  
  private
    def experiment_params
      params.require(:experiment).permit(:save_state)
    end
    
    def set_board
      @temp_experiment = Experiment.find(params[:id])
      @temp_board_state = @temp_experiment.save_state 
      @choice = params[:experiment][:choice]
      if @choice != nil
        @temp_board_state[@choice.to_i] = "3"
      end
      params[:experiment][:save_state] = @temp_board_state
      params[:experiment].delete("choice")
      
    end
end
