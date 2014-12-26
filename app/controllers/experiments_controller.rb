class ExperimentsController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @experiment = Experiment.find(params[:id])
    @counter = 0
    @board_state = @experiment.save_state
    @test = 0
  end

  def forms
    @user = User.new
  end
  
  def reversi
    @experiment = Experiment.new
    @counter = 0
    @board_state = 
      "0120120101201201012012010120120101201201012012010120120101201201"
  end
  
  def create
    @experiment = Experiment.new(experiment_params)
    if @experiment.save
      redirect_to @experiment
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
end
