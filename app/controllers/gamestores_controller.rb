class GamestoresController < ApplicationController
  before_action :set_user
  before_action :set_gamestores, only: [:show, :edit, :update, :destroy]
  
  def index
    @gamestores = @user.gamestores
  end
  
  def show
  end

  def new
    @characters = find_characters
    @gamestore = @user.gamestores.build
  end
  
  def create
    
    @gamestore = @user.gamestores.build(gamestore_params)
    if @gamestore.save
      redirect_to user_path(@user)
    else
      render 'index'
    end
  end

  def edit
    @characters = find_characters
  end
  
  def update
        if @gamestore.update(gamestore_params)
      redirect_to user_path(@user)
    else
      render 'index'
    end
  end
  
  def destroy
    @gamestore.destroy
    redirect_to user_path(@user)
  end
  
  private
  
    def gamestore_params
      params.require(:gamestore).permit(:id, :name, :turn, :char1 )
    end
    
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_gamestores
      @gamestore = @user.gamestores.find(params[:id])
    end
    
    def find_characters
      @user = User.find(params[:user_id])
      @characters = @user.characters
      @character_array = []
      @characters.each do |f|
        @temp = [f.name, f.id]
        @character_array.push(@temp)
      end
      return @character_array
    end
end
