class CharactersController < ApplicationController
  before_action :set_user
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  
  def index
    @characters = @user.characters
  end
  
  def show
  end
  
  #new action creates a new character instance variable
  def new
    @character = @user.characters.build
  end
  
  def create
    @character = @user.characters.build(character_params)
    if @character.save
      redirect_to user_path(@user)
    else
      render 'characters/new'
    end
  end
  
  def delete
    @character = Character.find(params[:id])
  end
  
  def destroy
    @character.destroy
    redirect_to user_path(@user)
  end
  
  def edit
  end
  
  def update
    if @character.update(character_params)
      redirect_to user_path(@user)
    else
      render 'characters/edit'
    end
  end

  private
  
    def character_params
      params.require(:character).permit(:id, :name, :strength, :defense, :hp_max,
        :hp_current)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_character
      @character = @user.characters.find(params[:id])
    end
end
