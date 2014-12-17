class CharactersController < ApplicationController
  
  def index
    @characters = Character.all
  end
  
  def show
    @character = Character.find(params[:id])
  end
  
  #new action creates a new character instance variable
  def new
    @character = Character.new
  end
  
  def create
    @character = Character.new(character_params)
    if @character.save
      redirect_to @character
    else
      redirect_to(forms_path)
    end
  end
  
  def delete
    @character = Character.find(params[:id])
  end
  
  def destroy
    Character.find(params[:id]).destroy
    redirect_to( forms_path)
  end
  
  def edit
    @character = Character.find(params[:id])
  end
  
  def update
    @character = Character.find(params[:id])
    if @character.update_attributes(character_params)
      redirect_to(action: 'show', id: @character.id)
    else
      render('index')
    end
  end

  private
  
    def character_params
      params.require(:character).permit(:name, :strength, :defense, :hp_max,
        :hp_current)
    end
end
