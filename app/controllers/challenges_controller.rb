class ChallengesController < ApplicationController
    
    def index
        @challenges = Challenge.all
    end

    def show
        @challenge = Challenge.find(params[:id])
    end

    def create
        @challenge = Challenge.new(challenge_params)
        if @challenge.save
            redirect_to @challenge
        end
    end
    
    def new
        @challenge = Challenge.new
    end
    
    def update
        @challenge = Challenge.find(params[:id])
        if @challenge.update(challenge_params)
           redirect @challenge
        else
           render :edit
        end
    end
    
    def destroy
        @challenge = User.find(params[:id]).destroy
        redirect_to @challenge
    end
    
    def edit
        @challenge = Challenge.find(params[:id])
    end
    
    private
    
        def challenge_params
            params.require(:challenge).permit(:name, :description, :code)
        end
end
