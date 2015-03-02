class TracksController < ApplicationController
  before_action :process_file, only: :create
  def index
  end

  def show
    @track = Track.find(params[:id])
    @string_array = @track.input.split("\n")
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
                                     :calibration_time, :recalibration_time)
    end
    
    # Convert the file to a string before saving
    def process_file
      temp_string = ""
      @file = params[:track][:input]
      filex = @file.open
      
      filex.each_line do |line|
        temp_string << line
      end
      
      params[:track][:input] = temp_string
    end
end
