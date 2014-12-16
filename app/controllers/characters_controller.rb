class CharactersController < ApplicationController
  #new action creates a new character instance variable
  def new
    @character = Character.new
  end
  
  def create
    @character = Character.new(character_params)
    @character.save
    redirect_to @character
  end
  
  def show
    @character = Character.find(params[:id])
  end
  
  private
  
    def character_params
      params.require(:character).permit(:name, :strength, :defense, :hp_max,
        :hp_current)
    end
end
