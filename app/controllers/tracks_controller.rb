class TracksController < ApplicationController
  include TracksHelper
  before_action :process_file, only: :create
  
  def index
  end

  def show
    @track = Track.find(params[:id])

    table_data = look_first(screen_data(@track.input), @track.number_of_trials, @track.trial_time,
                @track.calibration_time, @track.recalibration_time)
                
    @processed_table = process_table(table_data)
  end

  
  def new
    @track = Track.new
  end

  def create
    @track = Track.create(track_params)
    redirect_to @track
  end
  
  def edit
  end
  
  private
    
    def track_params
      params.require(:track).permit(:name, :input, :trial_time,
                                     :calibration_time, :recalibration_time,
                                     :number_of_trials)
    end
    
    # Convert the file to a string before saving
    def process_file
      temp_string = ""
      
      #removes the file from the params hash
      @file = params[:track][:input]
      filex = @file.open
      
      
      filex.each_line do |line|
        temp_string << line
      end
      
      #saves the string back to :input
      params[:track][:input] = temp_string
    end
    
end
