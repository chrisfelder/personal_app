class CharactersController < ApplicationController
  before_action :set_user
  before_action :set_character, only: [:show, :edit, :update, :destroy]
  before_action :set_class, only: :create
  
  def index
    @characters = @user.characters
  end
  
  def show
  end
  
  #new action creates a new character instance variable
  def new
    @character = @user.characters.build
    @classes = [["miner", "miner"], ["hunter", "hunter"], ["lumberjack", "lunberjack"]]
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
      params.require(:character).permit(:id, :name,
        :strength, :defense, :hp_current, :hp_max, :miner, :lumberjack, :hunter)
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_character
      @character = @user.characters.find(params[:id])
    end
    
    def set_class
      if params[:character][:class] == "miner"
        params[:character][:strength] = 12
        params[:character][:defense] = 10
        params[:character][:hp_max] = 100
        params[:character][:hp_current] = 100
        params[:character][:miner] = 1
        
      elsif params[:character][:class] == "hunter"
        params[:character][:strength] = 10
        params[:character][:defense] = 12
        params[:character][:hp_max] = 100
        params[:character][:hp_current] = 100
        params[:character][:hunter] = 1
      else
        params[:character][:strength] = 10
        params[:character][:defense] = 10
        params[:character][:hp_max] = 110
        params[:character][:hp_current] = 110
        params[:character][:lumberjack] = 1
      end
      params[:character].delete(:class)
    end
    
end
